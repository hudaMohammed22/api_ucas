import 'package:api_ucas/pojo/user.dart';

class ApiRrespose {
  bool? status;
  String? message;
  user? object;
  String? code;

  ApiRrespose({this.status, this.message, this.object});

  ApiRrespose.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    object =
    json['object'] != null ?  user.fromJson(json['object']) : null;
    code = json['code'];
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