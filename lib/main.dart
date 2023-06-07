import 'package:api_ucas/auth/login_screen.dart';
import 'package:api_ucas/home_page.dart';
import 'package:api_ucas/pojo/PorviderLang.dart';
import 'package:api_ucas/provider_class.dart';
import 'package:api_ucas/splash_screen.dart';
import 'package:api_ucas/student_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PorviderLang(),),
        ChangeNotifierProvider(create: (context) => PorviderClass(),),
      ],
      child: Consumer(
        builder: (context, value, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en'), // English
                Locale('ar'), // Spanish
              ],
              locale:Locale(Provider.of<PorviderLang>(context).lang) ,
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen()
          );
        },
      ),
    );
  }
}


