import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProfileController profileController = Get.put(ProfileController());
  final ApiController apiController = Get.put(ApiController());

  @override
  void onInit() async {
    if (apiController.account.value.data != null) {
      _homeUpdateLocation();
    } else {
      await apiController.getAccount();
      _homeUpdateLocation();
    }
    super.onInit();
  }

  _homeUpdateLocation() {
    profileController.getterLocations();
    if (profileController.isLoadingFinish.value) {
      if (apiController.account.value.data!.location == null) {
        if (apiController.account.value.data!.image == null) {
          apiController.updateAccount(
              "", profileController.longObs, profileController.latObs);
        } else {
          var currentImage = apiController.account.value.data!.image;
          apiController.updateAccount(currentImage.toString(),
              profileController.longObs.value, profileController.latObs.value);
        }
      }
    }
  }
}
