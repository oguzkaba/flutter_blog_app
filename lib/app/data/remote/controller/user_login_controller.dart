import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_categories_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/login_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  final user = UserLoginModel().obs;
  final isLoginLoading = true.obs;
  //var token = "";

  final PrefController prefController = Get.put(PrefController());

  setToken(String token) async {
    if (prefController.token.value != "") {
      await _initLoad(token);
    } else {
      prefController.token.value = token;
      prefController.isLogin.value = true;
      prefController.saveToPrefs();
      await _initLoad(token);
    }
  }

  _initLoad(String token) async {
    await GetBlogsController().getBlogs("", token);
    await GetCategoriesController().getCategories(token);
    await GetAccountController().getAccount(token);
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

      //await getAccount();
      isLoginLoading(false);
    }
  }
}
