
import 'package:api_ucas/auth/register_screen.dart';
import 'package:api_ucas/controller/api_controller.dart';
import 'package:api_ucas/home_page.dart';
import 'package:api_ucas/pojo/api_response.dart';
import 'package:api_ucas/student_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../pojo/PorviderLang.dart';
import '../widgets/app_text_field.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)!.login}",
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
              AppLocalizations.of(context)!.title,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: const Color(0xFF18978F),
              ),
            ),
            Text(
              "login_subtitle",
              style: GoogleFonts.nunito(
                height: 0.8,
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: const Color(0xFF54BAB9),
              ),
            ),
            const SizedBox(height: 20),
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
                onPressed: () async => _performLogin(),
                child: Text("login"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 45),
                    shadowColor: Colors.transparent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account',
                  style: GoogleFonts.nunito(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                  // ),
                  child: Text(
                    'Create Now!',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PorviderLang>(context,listen: false).changLang();
        },
        backgroundColor: const Color(0xFFE9DAC1),
        child: const Icon(
          Icons.language,
          color: Color(0xFF54BAB9),
        ),
      ),
    );
  }

  Future<void> _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _passwordTextController.text.length >= 6 &&
        _passwordTextController.text.length <= 30) {
      return true;
    }
    return false;
  }


  Future<void> _login() async {
   ApiRrespose rrespose = await ApiController().login(email:_emailTextController.text ,password:_passwordTextController.text);
   if(rrespose.status!){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentImages()));
   }
  }
}
