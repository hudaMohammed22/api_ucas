import 'dart:convert';
import 'dart:io';

import 'package:api_ucas/controller/api_mixin.dart';
import 'package:api_ucas/controller/api_setting.dart';
import 'package:api_ucas/pojo/ImageClass.dart';
import 'package:api_ucas/pojo/product.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../pojo/Post.dart';
import '../pojo/api_image.dart';
import '../pojo/api_response.dart';
import '../pojo/user.dart';

class ApiController with api_mixin {
//   Future<dynamic> getAllProduct() async {
//     Uri uri = Uri.parse(APISetting.get_all_product);
//     http.Response response = await http.get(uri);
//
//     if (response.statusCode == 200 || response.statusCode == 401) {
//       return json.decode(response.body);
//     }
//   }
//
//   getProductDetails(id) async {
//     Uri uri = Uri.parse(APISetting.get_all_product.replaceFirst("{id}", id));
//     http.Response response = await http.get(uri);
//
//     if (response.statusCode == 200 || response.statusCode == 401) {
//       return json.decode(response.body);
//     }
//   }
//
  getUserPosts(userId) async {
    var params = {"userId": userId};
    Uri uri = Uri.https("jsonplaceholder.typicode.com", "posts", params);
    http.Response response = await http
        .get(uri, headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 401) {
      return json.decode(response.body);
    }
  }

  Future<List<Post>> getAllPosts() async {
    List<Post> list = [];
    //url
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    //method
    http.Response response = await http.get(uri);

    //response
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      body.forEach((e) {
        list.add(Post.fromJson(e));
      });
    }
    return list;
  }

//
//   Future<List<Product>> setSaerchData() async {
//     List<Product> list = [];
//     var map = {
//       "minPrice": 20,
//       "maxPrice": 25,
//       "productType": "trend",
//       "productColor": "red",
//       "productSize": "32",
//       "categoryId": 1
//     };
// //url
//     Uri uri = Uri.parse("https://rrrstore103.com/api/products/search");
// //method
//     http.Response response = await http.post(
//       uri,
//       body: map,
//     );
//
// //response
//     if (response.statusCode == 200) {
//       var body = json.decode(response.body);
//       print(body);
//       if (body["success"]) {
//         body["date"].forEach((e) {
//           list.add(Product.fromJson(e));
//         });
//       }
//     }
//     return list;
//   }

  Future<ApiRrespose> login({email, password}) async {

    Uri url = Uri.parse(APISetting.login);
    var map = {"email": email, "password": password};

    http.Response response = await http.post(
      url,
      body: map,
      // headers: {HttpHeaders.contentTypeHeader: 'application/json'}
    );
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      ApiRrespose rrespose = ApiRrespose.fromJson(jsonResponse);
      if (response.statusCode == 200) {
        if (rrespose.object != null) {
          GetStorage().write("token", rrespose.object!.token);
          GetStorage().write("email", rrespose.object!.email);
          GetStorage().write("fullName", rrespose.object!.fullName);
        }
      }
      return rrespose;
    }
    return faildResponse;
  }

  Future<ApiRrespose> Rigester({required user user1}) async {
    Uri url = Uri.parse(APISetting.register);

    http.Response response = await http.post(
      url,
      body: user1.toJsonRegister(),
      // headers: {HttpHeaders.contentTypeHeader: 'application/json'}
    );

    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      ApiRrespose rrespose = ApiRrespose.fromJson(jsonResponse);
      return rrespose;
    }
    return faildResponse;
  }

  Future<ApiRrespose> ResetPassword({email, pass, repass, code}) async {
    Uri url = Uri.parse(APISetting.reset);
    var map = {
      "password_confirmation": repass,
      "password": pass,
      "code": code,
      "email": email
    };

    http.Response response = await http.post(url,
        body: map,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      ApiRrespose rrespose = ApiRrespose.fromJson(jsonResponse);
      return rrespose;
    }
    return faildResponse;
  }

  Future<ApiRrespose> ForgetPassword({email}) async {
    Uri url = Uri.parse(APISetting.forget);
    var map = {"email": email};

    http.Response response = await http.post(url,
        body: map,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      ApiRrespose rrespose = ApiRrespose.fromJson(jsonResponse);
      return rrespose;
    }
    return faildResponse;
  }

  Future<List<ImageClass>> getAllImages() async {
    List<ImageClass> list = [];
    //url
    Uri uri = Uri.parse("http://demo-api.mr-dev.tech/api/student/images");
    //method
    http.Response response = await http.get(uri,
        headers: {"Authorization": "Bearer "+GetStorage().read("token")});

    print(GetStorage().read("token"));
    print(response.statusCode);
    print(response.body);
    //response
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      body['data'].forEach((e) {
        list.add(ImageClass.fromJson(e));
      });
    }
    return list;
  }

  uploadImage({path}) async {
    Uri uri = Uri.parse("http://demo-api.mr-dev.tech/api/student/images");
    var request = http.MultipartRequest('POST',uri);
    http.MultipartFile file = await http.MultipartFile.fromPath("image", path);
    request.files.add(file);
    // request.fields['name'] = name;
    request.headers['Authorization'] = "Bearer "+GetStorage().read("token");

    http.StreamedResponse response = await request.send();
    if(response.statusCode == 201){
      var body = await response.stream.transform(utf8.decoder).first;
      return ApiRresposeImage.fromJson(jsonDecode(body));
    }
    return faildResponseiMAGE;

  }
}
