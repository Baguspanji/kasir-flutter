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
        body: Column(
          children: [
            SizedBox(height: height(context) * 0.01),
            Container(
              width: width(context),
              height: height(context) * 0.04,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: width(context) * 0.02),
                  Text(
                    'Ganti Password',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: InkWell(
                onTap: () async {
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
                child: Container(
                  width: width(context),
                  height: height(context) * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(17)),
                  child: Center(
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
    Widget suffixIcon = const SizedBox(),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            hint,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: width(context),
          margin: const EdgeInsets.only(bottom: 10),
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
            keyboardType: type,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Masukkan $hint',
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
