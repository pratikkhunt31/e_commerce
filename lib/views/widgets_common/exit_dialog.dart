// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure want to exit".text.color(darkFontGrey).size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(
                color: redColor,
                textColor: whiteColor,
                title: "Yes",
                onPress: () {
                  SystemNavigator.pop();
                }),
            button(
                color: redColor,
                textColor: whiteColor,
                title: "No",
                onPress: () {
                  Navigator.pop(context);
                })
          ],
        )
      ],
    ).box.color(lightGrey).roundedSM.padding(EdgeInsets.all(10)).make(),
  );
}
