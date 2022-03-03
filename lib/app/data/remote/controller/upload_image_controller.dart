import 'dart:io';

import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/upload_image_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class UploadImageController extends GetxController {
  final uploadImage = UploadImageModel().obs;
  final isUploadImageLoading = true.obs;
  final GetAccountController accountController = Get.find();

  Future<void> uploadImageApi(File file, String filename, String token) async {
    try {
      isUploadImageLoading(true);
      uploadImage.value =
          await RemoteServices.uploadImage(file, filename, token);
    } finally {
      await accountController.getAccount(token);
      isUploadImageLoading(false);
    }
  }
}
