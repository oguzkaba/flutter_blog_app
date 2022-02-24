import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/categories_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class GetCategoriesController extends GetxController {
  final categories = GetCategoriesModel().obs;
  final isGetCatLoading = true.obs;

  //Get Categories method
  Future<void> getCategories(String token) async {
    try {
      isGetCatLoading(true);
      categories.value = await RemoteServices.getCategories(token);
    } finally {
      isGetCatLoading(false);
    }
  }
}
