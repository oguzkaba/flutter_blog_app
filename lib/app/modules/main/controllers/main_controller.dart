import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_categories_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/update_get_account_controller.dart';
import 'package:flutter_blog_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:geolocator/geolocator.dart';
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
    await _addStartLocation(PrefController().getToken());
    super.onInit();
  }

  _initLoad(String token) async {
    await blogsController.getBlogs("", token);
    await categoriesController.getCategories(token);
    await accountController.getAccount(token);
  }

  _addStartLocation(String token) async {
    double lat = 0.0;
    double long = 0.0;

    await Geolocator.requestPermission().then((request) async {
      if (GetPlatform.isIOS || GetPlatform.isAndroid) {
        if (request == LocationPermission.denied ||
            request == LocationPermission.deniedForever) {
          return;
        } else {
          await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high)
              .then((pos) async {
            lat = pos.latitude;
            long = pos.longitude;
          });
        }
      }
    });

    if (accountController.account.value.data!.location == null) {
      await updateAccountController.updateAccount(
          accountController.account.value.data!.image, long, lat, token);
      profileController.isLoadingFinish.value = true;
      profileController.dragMarkerPosition.value = true;
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
