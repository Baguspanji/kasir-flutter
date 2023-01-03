import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height(context) * 0.2),
            Text(
              "Kasir",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: height(context) * 0.1),
            _input(
              context,
              "Username",
              Icon(
                Icons.person,
                color: primaryColor,
              ),
              emailText,
            ),
            SizedBox(height: 20),
            _input(
                context,
                "Password",
                Icon(
                  Icons.key,
                  color: primaryColor,
                ),
                passwordText,
                isPassword: true),
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
            Spacer(),
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
    );
  }

  Widget _input(
    BuildContext context,
    String hint,
    Icon icon,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Container(
      width: width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
