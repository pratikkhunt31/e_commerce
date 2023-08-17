// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/cart_controller.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/cart/shipping_screen.dart';
import 'package:e_commerce/views/widgets_common/button.dart';
import 'package:e_commerce/views/widgets_common/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          // width: context.screenWidth - 60,
          height: 50,
          child: button(
              color: redColor,
              onPress: () {
                Get.to(() => ShippingDetails());
              },
              textColor: whiteColor,
              title: "Procced to checkout"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is Empty!".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            '${data[index]['img']}',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title:
                              "${data[index]['title']} (x${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                          subtitle: "${data[index]['tprice']}"
                              .numCurrency
                              .text
                              .size(14)
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          trailing: Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        Obx(() => "${controller.totalP.value}"
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make())
                      ],
                    )
                        .box
                        .color(lightGolden)
                        .padding(EdgeInsets.all(12))
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                    5.heightBox,
                    // SizedBox(
                    //   width: context.screenWidth - 60,
                    //   child: button(
                    //       color: redColor,
                    //       onPress: () {},
                    //       textColor: whiteColor,
                    //       title: "Procced to checkout"),
                    // )
                  ],
                ),
              );
            }
          },
        ));
  }
}
