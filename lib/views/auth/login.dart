// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/lists.dart';
import 'package:e_commerce/controller/auth_controller.dart';
import 'package:e_commerce/views/auth/signup.dart';
import 'package:e_commerce/views/home/home.dart';
import 'package:e_commerce/views/widgets_common/applogo_widgets.dart';
import 'package:e_commerce/views/widgets_common/bg_widget.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:e_commerce/views/widgets_common/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  textField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  textField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {}, child: forgetPass.text.make()),
                  ),
                  5.heightBox,
                  // button().box.width(context.screenWidth-50).make()
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : button(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => Home());
                              } else {
                                controller.isLoading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  buttonon(
                      color: lightGolden,
                      title: signup,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => Signup());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Image.asset(socialIconList[index],
                                    width: 30),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
