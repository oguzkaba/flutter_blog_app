import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    if (controller.pController.hasClients) {
      controller.onClose();
      controller.onInit();
    }
    return Scaffold(
        body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.pController,
            children: pages),
        bottomNavigationBar: Obx(() => Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: myShadowColor,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                onTap: (value) => controller.pageindex(value),
                currentIndex: controller.pIndex.value,
                iconSize: 40,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile")
                ],
              ),
            )));
  }
}
