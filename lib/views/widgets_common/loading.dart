// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator() {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
