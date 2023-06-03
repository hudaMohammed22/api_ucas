import 'package:api_ucas/provider_class.dart';
import 'package:api_ucas/student_images.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,() async {
      await Provider.of<PorviderClass>(context,listen: false).getData();
      Widget w = GetStorage().read("token") != null ?StudentImages():LoginScreen();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => w,));
    },);
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
