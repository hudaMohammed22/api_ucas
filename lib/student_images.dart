import 'package:api_ucas/controller/api_controller.dart';
import 'package:api_ucas/pojo/ImageClass.dart';
import 'package:api_ucas/provider_class.dart';
import 'package:api_ucas/uplaod_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentImages extends StatefulWidget {
  @override
  State<StudentImages> createState() => _StudentImagesState();
}

class _StudentImagesState extends State<StudentImages> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImage()));
          },

            icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<PorviderClass>(
        builder: (context, value, child) {
          return GridView.builder(
            itemCount: value.list.length,//Provider.of<PorviderClass>(context).list.length
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Image.network("${value.list[index].imageUrl}"); //Provider.of<PorviderClass>(context).list[index].
            },
          );
        },

      )
    );
  }
}
