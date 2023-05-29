import 'package:api_ucas/pojo/ImageClass.dart';
import 'package:api_ucas/pojo/user.dart';

class ApiRresposeImage {
  bool? status;
  String? message;
  ImageClass? object;

  ApiRresposeImage({this.status, this.message, this.object});

  ApiRresposeImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    object =
    json['object'] != null ?  ImageClass.fromJson(json['object']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object!.toJson();
    }
    return data;
  }
}