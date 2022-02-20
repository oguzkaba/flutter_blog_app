// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/bottom_sheet_widget.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  // ignore: annotate_overrides
  final ProfileController controller = Get.put(ProfileController());
  final ApiController apiController = Get.put(ApiController());
  final PrefController prefController = Get.put(PrefController());

  @override
  Widget build(BuildContext context) {
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
                //TODO: ShowMap extract method
                child: Container(
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                      color: myRedColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: GoogleMap(initialCameraPosition:controller.currentLatLng!),
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
              child: apiController.uploadImage.data != null &&
                      apiController.isUploadImageLoading.value == false
                  ? Image.network(apiController.uploadImage.data.toString(),
                      width: 180, height: 180, fit: BoxFit.cover)
                  : Container(width: 180, height: 180, color: myGreyColor)),
          Positioned(
              bottom: 40,
              right: 20,
              child: IconButton(
                  onPressed: () {
                    CustomBottomSheetWidget.showBSheet(
                        context: Get.context,
                        controller: controller,
                        apiController: apiController);
                  },
                  icon: Icon(Icons.camera_alt, color: myDarkColor, size: 40)))
        ]));
  }

  ButtonWidget _logoutButton(BuildContext context) {
    return ButtonWidget(
      text: "Log Out",
      icon: Icons.logout,
      tcolor: myWhiteColor,
      onClick: () {
        prefController.deleteFromPrefs();
        Get.offAllNamed(Routes.LOGIN);
      },
      width: Get.width * .9,
      height: Get.height * .07,
      color: myDarkColor,
    );
  }

  ButtonWidget _saveButton(BuildContext context) {
    return ButtonWidget(
      text: "Save",
      icon: Icons.library_add_check_rounded,
      tcolor: myDarkColor,
      onClick: () async {
        //TODO: account update with image and map
        //Get.find<MainController>().pageindex(1);
        //Get.toNamed(Routes.MAIN);
      },
      width: Get.width * .9,
      height: Get.height * .07,
      color: myWhiteColor,
    );
  }
}
