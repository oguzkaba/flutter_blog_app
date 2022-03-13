import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/login_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  final user = UserLoginModel().obs;
  final isLoginLoading = true.obs;

  final PrefController prefController = Get.find();

  setToken(String token) async {
    prefController.token.value = token;
    prefController.isLogin.value = true;
    await prefController.saveToPrefs();
  }

//Login method
  Future<void> login(String email, String password) async {
    try {
      isLoginLoading(true);
      user.value = await RemoteServices.userLogin(email, password);
    } finally {
      if (user.value.hasError == false) {
        await setToken(user.value.data!.token!);
      }
      isLoginLoading(false);
    }
  }
}
