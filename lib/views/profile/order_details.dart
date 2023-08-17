// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/views/profile/components/order_place_details.dart';
import 'package:e_commerce/views/profile/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Summary".text.fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  title: "Placed",
                  icon: Icons.done,
                  showDone: true),
              orderStatus(
                  color: Colors.blue,
                  title: "Confirmed",
                  icon: Icons.thumb_up,
                  showDone: false),
              orderStatus(
                  color: Colors.orange[500],
                  title: "On Delivery",
                  icon: Icons.delivery_dining_sharp,
                  showDone: false),
              orderStatus(
                  color: Colors.purple,
                  title: "Delivered",
                  icon: Icons.done_all_rounded,
                  showDone: false),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlacedDetails(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .add_jm()
                          .format(data['order_date'].toDate()),
                      d2: data['payment_method'],
                      title1: "Order Date",
                      title2: "Payment Method"),
                  orderPlacedDetails(
                      d1: "unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .fontFamily(bold)
                                  .color(redColor)
                                  .make()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              Divider(),
              10.heightBox,
              "Order Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 15,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
