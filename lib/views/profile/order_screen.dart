// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/profile/order_details.dart';
import 'package:e_commerce/views/widgets_common/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .xl
                      .make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(bold)
                      .make(),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrdersDetails(
                            data: data[index],
                          ));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: darkFontGrey,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
