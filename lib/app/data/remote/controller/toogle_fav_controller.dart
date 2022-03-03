import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/toogle_favorite_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class ToogleFavController extends GetxController {
  //Toogle Favorites method
  Future<void> toggleFav(String id,token) async {
  final favorites = ToggleFavoriteModel().obs;
  final isToggleFavsLoading = true.obs;
  final GetAccountController getAccountController=Get.put(GetAccountController());

    try {
      isToggleFavsLoading(true);
      favorites.value = await RemoteServices.toggleFavorites(id, token);
    } finally {
      await getAccountController.getAccount(token);
      isToggleFavsLoading(false);
    }
  }
}