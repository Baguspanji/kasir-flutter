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
      backgroundColor: Colors.orangeAccent.shade200,
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
                child: Image(
                  image: AssetImage(logo),
                ),
              ),
              SizedBox(height: height(context) * 0.07),
              _input(
                context,
                "Username",
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                emailText,
              ),
              SizedBox(height: 20),
              _input(
                context,
                "Password",
                Icon(
                  Icons.key,
                  color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60),
                width: width(context),
                child: button("Log In",
                    onPressed: onLogin,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    color: Colors.white,
                    colorText: Colors.orangeAccent.shade200,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: height(context) * 0.1),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Syarat dan ketentuan berlaku',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: Colors.white,
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
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
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
