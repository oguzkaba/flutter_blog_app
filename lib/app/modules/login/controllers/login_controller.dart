import 'package:flutter_blog_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final isVisible = false.obs;
  //final ProfileController profileController = Get.put(ProfileController());
  @override
  void onInit() {
    //profileController.getterLocations();
    super.onInit();
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
