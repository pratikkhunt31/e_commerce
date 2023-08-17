// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/controller/home_controller.dart';
import 'package:e_commerce/views/cart/cart.dart';
import 'package:e_commerce/views/category/category.dart';
import 'package:e_commerce/views/home/home_screen.dart';
import 'package:e_commerce/views/profile/profile.dart';
import 'package:e_commerce/views/widgets_common/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbaritem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    var navbody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navbody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbaritem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
