import 'package:api_ucas/controller/api_controller.dart';
import 'package:api_ucas/pojo/Post.dart';
import 'package:api_ucas/pojo/product.dart';
import 'package:flutter/material.dart';

import 'controller/dataRepo.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Post>>(
        future: ApiController().getAllPosts(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.connectionState == ConnectionState.done && snapshot.data != null && snapshot.data!.isNotEmpty){
            return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data![index].title!),
                  subtitle: Text(snapshot.data![index].body!),
                ));
          }else {
            return Center(
              child: Text("no data found"),
            );
          }

        },
      ),
    );
  }
}
