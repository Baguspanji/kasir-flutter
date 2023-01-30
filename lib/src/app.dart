import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/route_config.dart';
import 'package:kasir_app/src/config/theme_config.dart';
import 'package:kasir_app/src/ui/splash/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir JJ',
      initialRoute: SplashUI.routeName,
      theme: theme(),
      getPages: routes,
    );
  }
}
