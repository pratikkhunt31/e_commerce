// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget button({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}