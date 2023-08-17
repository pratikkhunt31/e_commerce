// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/lists.dart';
import 'package:e_commerce/controller/auth_controller.dart';
import 'package:e_commerce/controller/profile_controller.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/auth/login.dart';
import 'package:e_commerce/views/chat_screen/message_screen.dart';
import 'package:e_commerce/views/profile/components/detail_card.dart';
import 'package:e_commerce/views/profile/edit_profile.dart';
import 'package:e_commerce/views/profile/order_screen.dart';
import 'package:e_commerce/views/profile/wishlist_screen.dart';
import 'package:e_commerce/views/widgets_common/bg_widget.dart';
import 'package:e_commerce/views/widgets_common/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
              child: Column(
            children: [
              //edit profile button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                    )).onTap(() {
                  controller.namecontroller.text = data['name'];
                  Get.to(() => editProfile(
                        data: data,
                      ));
                }),
              ),

              //use detail
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    data['imageUrl'] == ''
                        ? Image.asset(
                            imgProfile2,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        "${data['email']}".text.white.make()
                      ],
                    )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: whiteColor)),
                        onPressed: () async {
                          await Get.put(AuthController())
                              .signoutMethod(context);
                          Get.offAll(() => Login());
                        },
                        child: logout.text.fontFamily(semibold).white.make())
                  ],
                ),
              ),

              20.heightBox,

              FutureBuilder(
                future: FirestoreServices.getCounts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else {
                    var countData = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(
                            count: countData[0].toString(),
                            title: "in your cart",
                            width: context.screenWidth / 3.4),
                        detailsCard(
                            count: countData[1].toString(),
                            title: "in your wishlist",
                            width: context.screenWidth / 3.4),
                        detailsCard(
                            count: countData[2].toString(),
                            title: "your orders",
                            width: context.screenWidth / 3.4),
                      ],
                    );
                  }
                },
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     detailsCard(
              //         count: data['cart'],
              //         title: "in your cart",
              //         width: context.screenWidth / 3.4),
              //     detailsCard(
              //         count: data['wishlist'],
              //         title: "in your wishlist",
              //         width: context.screenWidth / 3.4),
              //     detailsCard(
              //         count: data['order'],
              //         title: "your orders",
              //         width: context.screenWidth / 3.4),
              //   ],
              // ),

              //buttons section
              20.heightBox,
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: lightGrey,
                  );
                },
                itemCount: profileButtonList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(() => OrderScreen());
                          break;
                        case 1:
                          Get.to(() => WishlistScreen());
                          break;
                        case 2:
                          Get.to(() => MessagesScreen());
                          break;
                      }
                    },
                    leading: Image.asset(
                      profileButtonIcon[index],
                      width: 22,
                    ),
                    title: profileButtonList[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  );
                },
              )
                  .box
                  .white
                  .rounded
                  .margin(EdgeInsets.all(12))
                  .padding(EdgeInsets.symmetric(horizontal: 16))
                  .shadowSm
                  .make()
                  .box
                  .color(redColor)
                  .make()
            ],
          ));
        }
      },
    )));
  }
}
