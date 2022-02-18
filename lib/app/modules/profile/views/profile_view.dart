// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/global/utils/responsive.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/bottom_sheet_widget.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
                Icon(Icons.chevron_left_rounded, color: myDarkColor, size: 35),
            onPressed: () => Get.find<MainController>().pageindex(1),
          ),
          title: Text('My Profile'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              vPaddingM,
              Expanded(
                child: _profileCircleImage(),
              ),
              vPaddingM,
              Expanded(
                child: Container(
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                      color: myDarkColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              vPaddingM,
              Expanded(
                child: _buttonColumn(context),
              )
            ],
          ),
        ));
  }

  Column _buttonColumn(BuildContext context) {
    return Column(children: [
      _saveButton(context),
      vPaddingS,
      _logoutButton(context),
    ]);
  }

  Widget _profileCircleImage() {
    return Obx(() => Stack(children: [
          ClipOval(
              child: controller.imageFileList!.isNotEmpty && controller.isSelected.value
                  ? Image.file(File(controller.imageFileList!.first.path),
                      width: 180, height: 180, fit: BoxFit.cover)
                  : Container(width: 180, height: 180,color: myGreyColor)),
          Positioned(
              bottom: 40,
              right: 20,
              child: IconButton(
                  onPressed: () {
                    CustomBottomSheetWidget.showBSheet(
                        context: Get.context, controller: controller);
                  },
                  icon: Icon(Icons.camera_alt, color: myDarkColor, size: 40)))
        ]));
  }
}

ButtonWidget _logoutButton(BuildContext context) {
  return ButtonWidget(
    text: "Log Out",
    icon: Icons.logout,
    tcolor: myWhiteColor,
    onClick: () {
      Get.toNamed(Routes.MAIN);
    },
    width: Responsive.isMobile(context) ? Get.width * .9 : Get.width * .3,
    height: Get.height * .07,
    color: myDarkColor,
    // onClick: _loginButtonPress(
    //     dvc, lc, apic, sc, _isButtonDisabled),
    // widget: dvc.loginLoading.value
    //     ? LoadingWidget(color: Global.white)
    //     : Text('Login'.tr,
    //         style:
    //             TextStyle(color: Global.white, fontSize: 18)),
  );
}

ButtonWidget _saveButton(BuildContext context) {
  return ButtonWidget(
    text: "Save",
    icon: Icons.library_add_check_rounded,
    tcolor: myDarkColor,
    onClick: () {
      Get.find<MainController>().pageindex(1);
      Get.toNamed(Routes.SIGNUP);
    },
    width: Responsive.isMobile(context) ? Get.width * .9 : Get.width * .3,
    height: Get.height * .07,
    color: myWhiteColor,

    // onClick: _loginButtonPress(
    //     dvc, lc, apic, sc, _isButtonDisabled),
    // widget: dvc.loginLoading.value
    //     ? LoadingWidget(color: Global.white)
    //     : Text('Login'.tr,
    //         style:
    //             TextStyle(color: Global.white, fontSize: 18)),
  );
}
