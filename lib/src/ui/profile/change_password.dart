import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/auth_controller.dart';

class ChangePasswordUI extends StatefulWidget {
  static const String routeName = '/change-password';

  @override
  State<ChangePasswordUI> createState() => _ChangePasswordUIState();
}

class _ChangePasswordUIState extends State<ChangePasswordUI> {
  final authCon = Get.find<AuthController>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: width(context),
              height: height(context),
              color: Colors.white,
            ),
            Container(
              width: width(context),
              height: height(context) * 0.11,
              decoration: BoxDecoration(
                gradient: bgGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (() => Get.back()),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xCEFFFFFF),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: secondaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                      Text(
                        'Ubah Password',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    // padding: const EdgeInsets.only(left: 20, right: 20),
                    children: [
                      const SizedBox(height: 10),
                      _input(
                        context,
                        'Password Lama',
                        oldPassword,
                        type: TextInputType.text,
                      ),
                      _input(
                        context,
                        'Password Baru',
                        newPassword,
                        type: TextInputType.text,
                      ),
                      _input(
                        context,
                        'Password Baru Lagi',
                        newPasswordType,
                        type: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height(context) * 0.02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: width(context),
                  child: button("Simpan", onPressed: () async {
                    bool res = await authCon.changePassword(
                      oldPassword.text,
                      newPassword.text,
                      newPasswordType.text,
                    );

                    if (res) {
                      getToast('Berhasil mengubah password');
                      // delay 2 second
                      await Future.delayed(const Duration(seconds: 2));

                      // back to list
                      Get.back();
                    } else {
                      getToast('Gagal mengubah password');
                    }
                  },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      colorText: Colors.white,
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: height(context) * 0.02),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    BuildContext context,
    String hint,
    TextEditingController controller, {
    bool isPassword = true,
    Widget suffixIcon = const SizedBox(),
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      width: width(context),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: secondaryColor),
        keyboardType: type,
        decoration: InputDecoration(
          fillColor: secondaryColor,
          hintText: hint,
          hintStyle: TextStyle(color: secondaryColor),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
