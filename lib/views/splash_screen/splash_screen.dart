// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/views/auth/login.dart';
import 'package:e_commerce/views/home/home.dart';
import 'package:e_commerce/views/widgets_common/applogo_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //create a method to change a screen
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      //Using GetX
      // Get.to(() => Login());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => Login());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
