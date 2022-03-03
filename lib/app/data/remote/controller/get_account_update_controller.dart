import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_update_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:get/get.dart';

class GetAccountUpdeteController extends GetxController {
  final upAccount = AccountUpdateModel().obs;
  final isGetAccountLoading = true.obs; //
  final GetAccountController accountController=Get.find();
   //UpdateAccount method
  Future<void> updateAccount(img, lng, ltd,token) async {
    try {
      isGetAccountLoading(true);
      upAccount.value = await RemoteServices.updateAccounts(
          img, lng.toString(), ltd.toString(),token);
    } finally {
      await accountController.getAccount(token);
      isGetAccountLoading(false);
    }
  }

}