import 'dart:async';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/auth_controller.dart';
import 'package:kasir_app/src/repository/s_preference.dart';
import 'package:kasir_app/src/ui/auth/index.dart';
import 'package:kasir_app/src/ui/nav_ui.dart';

class SplashUI extends StatefulWidget {
  static const String routeName = "/splash";

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  final conAuth = Get.put(AuthController());

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await Future.delayed(Duration(seconds: 2));
    getToken().then((value) async {
      if (value != null) {
        await conAuth.getUser();
        Get.offAllNamed(NavUI.routeName);
      } else {
        Get.offAllNamed(AuthUI.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(color: primaryColor),
        child: Column(
          children: [
            SizedBox(height: 300),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(color: Colors.orangeAccent, width: 2),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Column(
            //     children: [
            //       Container(
            //         width: 200,
            //         height: 200,
            //         alignment: Alignment.center,
            //         padding: EdgeInsets.all(20),
            //         decoration: BoxDecoration(
            //           color: Colors.orangeAccent.shade200,
            //           borderRadius: BorderRadius.circular(100),
            //         ),
            //         child: Image(
            //           image: AssetImage(logo),
            //         ),
            //       ),
            //       SizedBox(height: 12),
            //       Text(
            //         'Kasir JJ',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           fontSize: 32,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Kasir JJ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
