import 'dart:io';

import 'package:api_ucas/pojo/api_image.dart';
import 'package:api_ucas/pojo/api_response.dart';
import 'package:api_ucas/provider_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'controller/api_controller.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker picker = ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            file == null?Image.network("https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",height: 200,width: 200,):Image.file( File(file!.path)),
            ElevatedButton(onPressed: () async {
              file = await picker.pickImage(source: ImageSource.gallery);
              setState(() {
              });
            }, child: Text("getImage")),
            ElevatedButton(onPressed: () async {
              ApiRresposeImage responce = await ApiController().uploadImage(path: file!.path);
              if(responce.status!){

                Provider.of<PorviderClass>(context,listen: false).updateList(responce.object!);
                Navigator.pop(context);
              }
            }, child: Text("upload")),
          ],
        ),
      ),
    );
  }
}
