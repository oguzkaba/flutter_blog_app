import 'package:flutter_blog_app/app/data/remote/model/login_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final isVisible = false.obs;

  @override
  void onInit() {
    //TODO: Net Control
    //if (!netContoller.isOnline) {
    // if (localDBController.questionsData.isEmpty) {
    // } else {
    //   localDBController.getData();
    // }
    // } else {}
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please fill Email';
    } else if (value.length < 6) {
      return 'Email must be 6 length character';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please fill password';
    } else if (value.length < 6) {
      return 'Password must be 6 length character';
    } else {
      return null;
    }
  }
}
