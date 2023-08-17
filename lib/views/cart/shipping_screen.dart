// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/views/cart/payment.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:e_commerce/views/widgets_common/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: button(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => Payment());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            color: redColor,
            textColor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            textField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            textField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            textField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            textField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            textField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
