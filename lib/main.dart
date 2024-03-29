// ignore_for_file: prefer_const_constructorsevice_preview/device_preview.dart';, prefer_const_constructors
import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    enabled: kReleaseMode,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      locale: DevicePreview.locale(context),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            // to set appbar icons color
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: SplashScreen(),
    );
  }
}
