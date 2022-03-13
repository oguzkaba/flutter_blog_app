import 'package:flutter_blog_app/app/data/remote/model/blog_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class GetBlogsController extends GetxController {
  final blogs = GetBlogsModel().obs;
  final isGetBlogsLoading = true.obs;

   @override
  void onInit() {
    blogs.value=GetBlogsModel();
    GetBlogsController().update();
    super.onInit();
  }

  //Get Blogs method
  Future<void> getBlogs(String? id, String token) async {
    try {
      isGetBlogsLoading(true);
      blogs.value = await RemoteServices.getBlogs(id ?? "", token);
    } finally {
      isGetBlogsLoading(false);
    }
  }
}
