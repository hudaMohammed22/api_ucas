import 'package:api_ucas/pojo/ImageClass.dart';
import 'package:api_ucas/pojo/user.dart';

class APIResponse<T> {
  bool? status;
  String? message;
  T? object;

  APIResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if(T is user){
      object =  json['object'] != null ?  user.fromJson(json['object'])  as T : null;
    }else {
      object = json['object'] != null ?  ImageClass.fromJson(json['object']) as T: null ;
    }


  }

}