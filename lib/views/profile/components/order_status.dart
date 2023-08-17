// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).padding(EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone
              ? Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
