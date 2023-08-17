// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/lists.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/views/home/home.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:e_commerce/views/widgets_common/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : button(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place Order"),
        ),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4)),
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Stack(alignment: Alignment.topRight, children: [
                    Image.asset(
                      paymentMethodImg[index],
                      width: double.infinity,
                      height: 120,
                      colorBlendMode: controller.paymentIndex.value == index
                          ? BlendMode.darken
                          : BlendMode.color,
                      color: controller.paymentIndex.value == index
                          ? Colors.black.withOpacity(0.4)
                          : Colors.transparent,
                      fit: BoxFit.cover,
                    ),
                    controller.paymentIndex.value == index
                        ? Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                value: true,
                                onChanged: (value) {}),
                          )
                        : Container(),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: paymentMethods[index]
                            .text
                            .white
                            .fontFamily(semibold)
                            .size(16)
                            .make())
                  ]),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
