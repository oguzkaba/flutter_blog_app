import 'package:flutter_blog_app/app/data/remote/controller/user_login_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/sign_up_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final newUser = SignUpModel().obs;
  final isSignUpLoading = true.obs;
  final UserLoginController userLoginController =
      Get.put(UserLoginController());

//SignUp method
  Future<void> signUp(String email, String password, String password2) async {
    try {
      isSignUpLoading(true);
      newUser.value = await RemoteServices.signUp(email, password, password2);
    } finally {
      if (newUser.value.hasError == false) {
        await userLoginController.login(email, password);
      }
      isSignUpLoading(false);
    }
  }
}
