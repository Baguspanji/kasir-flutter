import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/auth_controller.dart';
import 'package:kasir_app/src/ui/nav_ui.dart';

class AuthUI extends StatefulWidget {
  static String routeName = "/auth";

  @override
  State<AuthUI> createState() => _AuthUIState();
}

class _AuthUIState extends State<AuthUI> {
  final conAuth = Get.put(AuthController());

  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  bool isPassword = true;

  void onLogin() async {
    if (emailText.text == '' || passwordText.text == '') {
      getToast('Email dan Password tidak boleh kosong');
    } else {
      var auth = await conAuth.login(emailText.text, passwordText.text);
      if (auth) {
        getToast('Berhasil Login');
        Get.offAllNamed(NavUI.routeName);
      } else {
        getToast('Username atau Password salah');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height(context) * 0.17),
              Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.shade200,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image(
                  image: AssetImage(logo),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Kasir JJ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: height(context) * 0.07),
              _input(
                context,
                "Username",
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                emailText,
              ),
              SizedBox(height: 20),
              _input(
                context,
                "Password",
                Icon(
                  Icons.key,
                  color: Colors.grey,
                ),
                passwordText,
                isPassword: isPassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  child: Icon(
                    isPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: width(context),
                child: button(
                  "Login",
                  onPressed: onLogin,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                ),
              ),
              SizedBox(height: height(context) * 0.1),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Syarat dan ketentuan berlaku',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    BuildContext context,
    String hint,
    Icon icon,
    TextEditingController controller, {
    bool isPassword = false,
    Widget suffixIcon = const SizedBox(),
  }) {
    return Container(
      width: width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
