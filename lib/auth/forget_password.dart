import 'package:api_ucas/pojo/api_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/api_controller.dart';
import '../provider_class.dart';
import '../widgets/app_text_field.dart';

class ForgetPasswordPage extends StatefulWidget {

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          AppTextField(
            textController: _emailTextController,
            hint: "email",
            prefixIcon: Icons.email,
            textInputType: TextInputType.emailAddress,
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
              onPressed: () async => _performAction(),
              child: Text("login"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 45),
                  shadowColor: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  _performAction() async {
    if(_emailTextController.text.isNotEmpty){
      ApiRrespose rrespose = await ApiController().ForgetPassword(email: _emailTextController.text);
      if(rrespose.status!){
        Provider.of<PorviderClass>(context,listen: false).code = rrespose.code??"";
        Provider.of<PorviderClass>(context,listen: false).email = _emailTextController.text;

      }
    }
  }
}
