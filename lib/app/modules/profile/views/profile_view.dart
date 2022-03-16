// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/update_get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/upload_image_controller.dart';
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

  final UpdeteGetAccountController getAccountUpdeteController =
      Get.put(UpdeteGetAccountController());
  final UploadImageController uploadImageController =
      Get.put(UploadImageController());
  final PrefController prefController = Get.put(PrefController());

  @override
  Widget build(BuildContext context) {
    final GetAccountController accountController = Get.find();
    return WillPopScope(
      onWillPop: () async {
        Get.find<MainController>().pageindex(1);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left_rounded,
                  color: myDarkColor, size: 35),
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
                  child: Obx(() => _profileCircleImage(accountController)),
                ),
                vPaddingM,
                Expanded(
                  child: Obx(() => _showMap(accountController)),
                ),
                vPaddingM,
                Expanded(
                  child: _buttonColumn(context, accountController),
                )
              ],
            ),
          )),
    );
  }

  Container _showMap(GetAccountController accountController) {
    return Container(
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            color: myWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: controller.dragMarkerPosition.value &&
                controller.isLoadingFinish.value &&
                accountController.isGetAccountLoading.value == false
            ? GoogleMap(
                // onLongPress: (longPressValue) =>
                //     controller.longPress(longPressValue),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (mapController) =>
                    controller.mapController = mapController,
                onCameraMove: ((position) =>
                    controller.currentLatLng = position),
                markers: controller.isLoadingFinish.value &&
                        accountController.isGetAccountLoading.value == false &&
                        accountController.account.value.data!.location != null
                    ? controller.addMark(
                        LatLng(
                            double.parse(accountController
                                .account.value.data!.location["Latitude"]),
                            double.parse(accountController
                                .account.value.data!.location["Longtitude"])),
                        )
                    : Set<Marker>.of(controller.markers),
                initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(
                      double.parse(accountController
                          .account.value.data!.location["Latitude"]),
                      double.parse(accountController
                          .account.value.data!.location["Longtitude"]),
                    )))
            : Center(child: CircularProgressIndicator()));
  }

  Column _buttonColumn(
      BuildContext context, GetAccountController accountController) {
    return Column(children: [
      _saveButton(context, accountController),
      vPaddingS,
      _logoutButton(context, accountController),
    ]);
  }

  Widget _profileCircleImage(GetAccountController accountController) {
    return Stack(children: [
      ClipOval(
          child: controller.isLoadingFinish.value == false
              ? Center(child: CircularProgressIndicator(color: myDarkColor))
              : uploadImageController.uploadImage.value.data != null &&
                      uploadImageController.isUploadImageLoading.value == false
                  ? Image.network(uploadImageController.uploadImage.value.data!,
                      width: Get.height * .22,
                      height: Get.height * .22,
                      fit: BoxFit.cover)
                  : (accountController.isGetAccountLoading.value == false &&
                          accountController.account.value.data!.image != null &&
                          accountController.account.value.data!.image !=
                              "string" &&
                          accountController.account.value.data!.image != "")
                      ? Image.network(
                          accountController.account.value.data!.image,
                          width: Get.height * .22,
                          height: Get.height * .22,
                          fit: BoxFit.cover)
                      : Container(
                          width: Get.height * .22,
                          height: Get.height * .22,
                          color: myGreyColor)),
      Positioned(
          bottom: Get.height * .07,
          right: Get.width * .03,
          child: IconButton(
              onPressed: () {
                CustomBottomSheetWidget.showBSheet(
                    context: Get.context,
                    controller: controller,
                    uploadImageController: uploadImageController);
              },
              icon: Icon(Icons.camera_alt, color: myDarkColor, size: 40)))
    ]);
  }

  ButtonWidget _logoutButton(
      BuildContext context, GetAccountController accountController) {
    return ButtonWidget(
      text: "Log Out",
      icon: Icons.logout,
      tcolor: myWhiteColor,
      onClick: () async {
        Get.dialog(AlertDialog(
          title: Text("Will be logged out?",
              textAlign: TextAlign.center,
              style: TextStyle(color: myDarkColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              vPaddingL,
              ButtonWidget(
                text: "Logout",
                icon: Icons.logout_rounded,
                tcolor: myWhiteColor,
                onClick: () async {
                  await prefController.deleteFromPrefs();
                  Get.offAllNamed(Routes.LOGIN);
                },
                width: Get.width * .7,
                height: Get.height * .07,
                color: myDarkColor,
              ),
              vPaddingS,
              ButtonWidget(
                text: "Cancel",
                icon: Icons.cancel_rounded,
                tcolor: myDarkColor,
                onClick: () => Get.back(),
                width: Get.width * .7,
                height: Get.height * .07,
                color: myWhiteColor,
              )
            ],
          ),
        ));
      },
      width: Get.width * .9,
      height: Get.height * .07,
      color: myDarkColor,
    );
  }

  ButtonWidget _saveButton(
      BuildContext context, GetAccountController accountController) {
    return ButtonWidget(
      text: "Save",
      icon: Icons.library_add_check_rounded,
      tcolor: myDarkColor,
      onClick: () async {
        if (accountController.account.value.data != null) {
          await getAccountUpdeteController
              .updateAccount(
                  uploadImageController.uploadImage.value.data ??
                      accountController.account.value.data!.image,
                  controller.longObs.value,
                  controller.latObs.value,
                  PrefController().getToken())
              .whenComplete(() => Get.dialog(AlertDialog(
                    title: Text("Başarılı..!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: myRedColor)),
                    content: Container(
                        width: Get.width * .5,
                        //height: Get.height * .1,
                        child: Text("Bilgileriniz güncellenmiştir.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: myDarkColor))),
                    actions: [
                      Center(
                          child: ButtonWidget(
                              icon: Icons.check_circle,
                              tcolor: myWhiteColor,
                              width: Get.width * .3,
                              height: Get.height * .05,
                              color: myDarkColor,
                              text: "Tamam",
                              onClick: () => Get.back()))
                    ],
                  )));
        }
      },
      width: Get.width * .9,
      height: Get.height * .07,
      color: myWhiteColor,
    );
  }
}
