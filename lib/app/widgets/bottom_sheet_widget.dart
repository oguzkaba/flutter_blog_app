import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/upload_image_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomBottomSheetWidget {
  static void showBSheet(
      {required BuildContext? context,
      required UploadImageController uploadImageController,
      required ProfileController controller}) {
    Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: myGreyColor,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: myWhiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Expanded(
                flex: 5,
                child: _imagePreview(controller),
              ),
              vPaddingS,
              Expanded(child: _buttonGroup(controller, uploadImageController)),
              vPaddingS
            ]),
          ),
        ),
        elevation: 5);
  }

  static Widget _imagePreview(ProfileController controller) {
    return Obx(() => Stack(alignment: Alignment.center, children: [
          Container(
              width: Get.width * .9,
              height: Get.height * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: myGreyColor,
              ),
              child: controller.imageFileList!.isEmpty
                  ? SizedBox.shrink()
                  : Image.file(File(controller.imageFileList!.first.path),
                      fit: BoxFit.cover)),
          Visibility(
            visible: controller.imageFileList!.isEmpty,
            child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 60,
                onPressed: () => Get.dialog(AlertDialog(
                      title: Text("Select a Picture",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: myDarkColor)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonWidget(
                            text: "Camera",
                            icon: Icons.camera_alt_rounded,
                            tcolor: myWhiteColor,
                            onClick: () => controller.openSelectedPicker(
                                Get.context!, ImageSource.camera),
                            width: Get.width * .7,
                            height: Get.height * .07,
                            color: myDarkColor,
                          ),
                          vPaddingS,
                          ButtonWidget(
                            text: "Gallery",
                            icon: Icons.photo_library,
                            tcolor: myDarkColor,
                            onClick: () => controller.openSelectedPicker(
                                Get.context!, ImageSource.gallery),
                            width: Get.width * .7,
                            height: Get.height * .07,
                            color: myWhiteColor,
                          )
                        ],
                      ),
                    )),
                icon: Icon(Icons.camera_alt_rounded, color: myDarkColor)),
          )
        ]));
  }

  static Row _buttonGroup(
      ProfileController controller, UploadImageController uploadImageController) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            text: "Select",
            icon: Icons.touch_app_rounded,
            tcolor: myWhiteColor,
            onClick: () async {
              if (controller.isSelected.value == false) {
                Get.dialog(AlertDialog(
                  title: Text("Warning..!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: myRedColor)),
                  content: Container(
                      width: Get.width * .5,
                      //height: Get.height * .1,
                      child:  Text("No selected Image File...",
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
                ));
              } else {
                final image = controller.imageFileList!.first.path;
                controller.isSelected.value = true;
                await uploadImageController.uploadImageApi(File(image), image,PrefController().getToken());
                controller.imageFileList!.clear();
                Get.back();
              }
            },
            width: Get.width * .425,
            height: Get.height * .07,
            color: myDarkColor,
          ),
          hPaddingS,
          ButtonWidget(
            text: "Remove",
            icon: Icons.delete_forever_rounded,
            tcolor: myDarkColor,
            onClick: () {
              controller.isSelected.value = false;
              controller.imageFileList!.clear();
            },
            width: Get.width * .425,
            height: Get.height * .07,
            color: myWhiteColor,
          )
        ]);
  }
}
