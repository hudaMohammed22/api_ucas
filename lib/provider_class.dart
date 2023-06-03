import 'package:api_ucas/pojo/ImageClass.dart';
import 'package:api_ucas/pojo/api_r.dart';
import 'package:api_ucas/pojo/user.dart';
import 'package:flutter/cupertino.dart';

import 'controller/api_controller.dart';

class PorviderClass extends ChangeNotifier {
  String code = "";
  String email = "";

  List<ImageClass> list = [];

  getData() async {
   list = await ApiController().getAllImages();
   notifyListeners();
  }

  updateList(ImageClass c){
    list.add(c);
    notifyListeners();
  }
}