import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/global/controller/network_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/widgets/nav_badge_icon_widget.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final NetworkController netContoller = Get.put(NetworkController());

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
                type: BottomNavigationBarType.fixed,
                onTap: (value) => controller.pageindex(value),
                currentIndex: controller.pIndex.value,
                iconSize: 40,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      icon: NavBadgeIcon(
                        iconData: Icons.favorite,
                        notificationCount: Get.find<GetAccountController>()
                                .isGetAccountLoading
                                .value
                            ? 0
                            : Get.find<GetAccountController>()
                                .favoriteBlog
                                .length,
                      ),
                      label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile")
                ],
              ),
            )));
  }
}
