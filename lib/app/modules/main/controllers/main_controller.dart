import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_categories_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/update_get_account_controller.dart';
import 'package:flutter_blog_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final pIndex = 1.obs;
  PageController pController = PageController(initialPage: 1);
  final GetBlogsController blogsController = Get.put(GetBlogsController());
  final GetCategoriesController categoriesController =
      Get.put(GetCategoriesController());
  final GetAccountController accountController =
      Get.put(GetAccountController());
  final UpdeteGetAccountController updateAccountController =
      Get.put(UpdeteGetAccountController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void onInit() async {
    pController = PageController(initialPage: pIndex.value);
    await _initLoad(PrefController().getToken());
    super.onInit();
  }

  _initLoad(String token) async {
    await blogsController.getBlogs("", token);
    await categoriesController.getCategories(token);
    await accountController.getAccount(token);
    if (accountController.account.value.data!.location == null &&
        profileController.isLoadingFinish.value) {
      await updateAccountController.updateAccount(
          accountController.account.value.data!.image,
          profileController.longObs,
          profileController.latObs,
          token);
    } else {
      profileController.getterLocations();
      await updateAccountController.updateAccount(
          accountController.account.value.data!.image,
          profileController.longObs,
          profileController.latObs,
          token);
    }
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
}
