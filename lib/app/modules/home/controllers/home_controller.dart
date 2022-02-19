import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiController apiController = Get.put(ApiController());
  final categoriesItem = [].obs;
  final blogsItem = [].obs;
  final toogleFav = false.obs;
  final RxList indexFav = [].obs;
  final accountItem = [].obs;

  @override
  void onInit() async {
    await apiController
        .getCategories()
        .then((value) => categoriesItem.value = apiController.categories.data!);
    await apiController
        .getBlogs("")
        .then((value) => blogsItem.value = apiController.blogs.data!);

    await apiController.getAccount().then((value) {
      if (apiController.account.data!.favoriteBlogIds.isEmpty) {
        accountItem.value = [];
      } else {
        accountItem.value = apiController.account.data!.favoriteBlogIds;
      }
    });

    super.onInit();
  }
}
