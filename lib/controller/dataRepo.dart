// import 'package:api_ucas/controller/api_controller.dart';
// import 'package:api_ucas/pojo/Post.dart';
//
// import '../pojo/product.dart';
//
// class DataRepo {
//   ApiController _apiController = ApiController();
//
//   Future<List<Product>> getAllProduct() async {
//     return await  _apiController.getAllProduct().then((value){
//       List<Product> p = [];
//       if(value["success"]){
//         value["data"].forEach((e){
//           p.add(Product.fromJson(e));
//         });
//       }
//       return p;
//     });
//   }
//   Future<List<Post>> getAllPost()  async {
//     var x =  await _apiController.getUserPosts(1);
//     List<Post> p =[];
//     x.forEach((e){
//       p.add(Post.fromJson(e));
//     });
//     return p;
//   }
// }