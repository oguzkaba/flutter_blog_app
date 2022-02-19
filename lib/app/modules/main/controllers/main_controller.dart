import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  final pIndex = 1.obs;
  PageController pController = PageController(initialPage: 1, keepPage: true);
  @override
  void onInit() {
    pController = PageController(initialPage: pIndex.value, keepPage: true);
    super.onInit();
  }

  void pageindex(int value) {
    pIndex.value = value;
    pController.jumpToPage(value);
  }

  @override
  void dispose() {
    pController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
