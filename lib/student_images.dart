import 'package:api_ucas/controller/api_controller.dart';
import 'package:api_ucas/pojo/ImageClass.dart';
import 'package:api_ucas/uplaod_image.dart';
import 'package:flutter/material.dart';

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
            icon: Icon(Icons.add))],
      ),
      body: FutureBuilder<List<ImageClass>>(
          future: ApiController().getAllImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null &&
                snapshot.data!.isNotEmpty) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Image.network("${snapshot.data![index].imageUrl}");
                },
              );
            } else {
              return Center(
                child: Text("no data found"),
              );
            }
          }),
    );
  }
}
