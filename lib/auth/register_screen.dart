import 'package:api_ucas/auth/login_screen.dart';
import 'package:api_ucas/home_page.dart';
import 'package:api_ucas/pojo/api_response.dart';
import 'package:api_ucas/pojo/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/api_controller.dart';
import '../pojo/user.dart';
import '../widgets/app_text_field.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>  {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF18978F)),
        title: Text(
          "register",
          style: GoogleFonts.nunito(
            color: const Color(0xFF18978F),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "register_title",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: const Color(0xFF18978F),
              ),
            ),
            Text(
              "register_subtitle",
              style: GoogleFonts.nunito(
                height: 0.8,
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: const Color(0xFF54BAB9),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              textController: _nameTextController,
              hint:"name",
              prefixIcon: Icons.person,
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            AppTextField(
              textController: _emailTextController,
              hint: "email",
              prefixIcon: Icons.email,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            AppTextField(
              textController: _passwordTextController,
              hint: "password",
              prefixIcon: Icons.lock,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (String value) {
                //TODO: Call Login Function
              },
            ),
            const SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [
                        Color(0xFF54BAB9),
                        Color(0xFF18978F),
                      ]),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.black45,
                      blurRadius: 4,
                    )
                  ]),
              child: ElevatedButton(
                onPressed: () async => await _performRegister(),
                child: Text("register"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 45),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Provider.of<LanguageProvider>(context, listen: false)
          //     .changeLanguage();
        },
        backgroundColor: const Color(0xFFE9DAC1),
        child: const Icon(
          Icons.language,
          color: Color(0xFF54BAB9),
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }

    // showSnackBar(context:context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _register() async {
   ApiRrespose rrespose = await  ApiController().Rigester(user1: user1);
   if(rrespose.status!){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
   }
  }
  user get user1 {
    user user1 = user();
    user1.fullName = _nameTextController.text;
    user1.email = _emailTextController.text;
    user1.password = _passwordTextController.text;
    user1.gender = "M";
    return user1;
  }
}
