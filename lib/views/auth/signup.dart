// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/auth_controller.dart';
import 'package:e_commerce/views/home/home.dart';
import 'package:e_commerce/views/widgets_common/applogo_widgets.dart';
import 'package:e_commerce/views/widgets_common/bg_widget.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:e_commerce/views/widgets_common/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Sign up to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  textField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  textField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  textField(
                      hint: passwordHint,
                      title: password,
                      controller: passController,
                      isPass: true),
                  textField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: passRetypeController,
                      isPass: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make()),
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: semibold, color: fontGrey)),
                          TextSpan(
                              text: terms,
                              style: TextStyle(
                                  fontFamily: semibold, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: semibold, color: fontGrey)),
                          TextSpan(
                              text: privacy,
                              style: TextStyle(
                                  fontFamily: semibold, color: redColor))
                        ])),
                      )
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : button(
                          color: isCheck == true ? redColor : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isLoading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isLoading(false);
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      already.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
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
            ),
          ],
        ),
      ),
    ));
  }
}
