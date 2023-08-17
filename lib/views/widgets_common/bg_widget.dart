// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill),
    ),
    child: child,
  );
}