// ignore_for_file: camel_case_types, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/profile_controller.dart';
import 'package:e_commerce/views/widgets_common/bg_widget.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:e_commerce/views/widgets_common/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class editProfile extends StatelessWidget {
  final dynamic data;

  const editProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //if data image url and controller path is empty
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()

                //if data is not empty but controller path is empty
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    //if both are empty
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            button(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            Divider(),
            20.heightBox,
            textField(
              controller: controller.namecontroller,
              hint: nameHint,
              title: name,
              isPass: false,
            ),
            10.heightBox,
            textField(
                controller: controller.oldpasscontroller,
                hint: passwordHint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            textField(
                controller: controller.newpasscontroller,
                hint: passwordHint,
                title: newpass,
                isPass: true),
            20.heightBox,
            controller.isLoading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: button(
                        color: redColor,
                        onPress: () async {
                          controller.isLoading(true);

                          //if image is not selected
                          if (controller.profileImgPath.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImgLink = data['imageUrl'];
                          }

                          //if old pass match to the database
                          if (data['password'] ==
                              controller.oldpasscontroller.text) {
                            await controller.changeAuthPass(
                                email: data['email'],
                                password: controller.oldpasscontroller.text,
                                newpassword: controller.newpasscontroller.text);
                            await controller.updateProfile(
                                imgUrl: controller.profileImgLink,
                                name: controller.namecontroller.text,
                                password: controller.newpasscontroller.text);
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "Wrong Old Password");
                            controller.isLoading(false);
                          }
                        },
                        textColor: whiteColor,
                        title: "Save"),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .roundedSM
            .make(),
      ),
    ));
  }
}
