import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class GetAccountController extends GetxController {
  final account = AccountModel().obs;
  final isGetAccountLoading = true.obs;
  final GetBlogsController getBlogsController =
      Get.put(GetBlogsController());

  Future<void> getAccount(String token) async {
    try {
      isGetAccountLoading(true);
      account.value = await RemoteServices.getAccounts(token);
    } finally {
      favGetFavBlogList();
      isGetAccountLoading(false);
    }
  }

  List favGetFavBlogList() {
    var favoriteBlog = [];
    if (account.value.data!.favoriteBlogIds.isEmpty) {
      return favoriteBlog = [];
    } else {
      for (var favorite in account.value.data!.favoriteBlogIds) {
        for (var article in getBlogsController.blogs.value.data!) {
          if (favorite == article.id) {
            favoriteBlog.add(article);
          }
        }
      }
      return favoriteBlog;
    }
  }
}
