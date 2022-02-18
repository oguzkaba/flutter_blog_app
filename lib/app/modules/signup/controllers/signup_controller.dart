import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final passwordRetry = ''.obs;
  final isVisible = false.obs;
  final formKey = GlobalKey<FormState>().obs;

  @override
  void onInit() {
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

  String? validatePasswordRetry(String? value) {
    if (value!.isEmpty) {
      return 'Please fill password retry';
    } else if (value.length < 6) {
      return 'Password retry must be 6 length character';
    } else {
      return null;
    }
  }
}
