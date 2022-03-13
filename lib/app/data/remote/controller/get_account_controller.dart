import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class GetAccountController extends GetxController {
  final account = AccountModel().obs;
  final isGetAccountLoading = true.obs;
  final favoriteBlog = [].obs;
  final GetBlogsController getBlogsController = Get.find();

  @override
  void onInit() {
    account.value=AccountModel();
    favoriteBlog.value = [];
    GetAccountController().update();
    super.onInit();
  }

  Future<void> getAccount(String token) async {
    try {
      isGetAccountLoading(true);
      account.value = await RemoteServices.getAccounts(token);
    } finally {
      if (getBlogsController.blogs.value.data == null) {
        await getBlogsController.getBlogs("", token);
      }
      favoriteBlog.value = account.value.data!.favoriteBlogIds;
      //favGetFavBlogList();
      isGetAccountLoading(false);
    }
  }
}
