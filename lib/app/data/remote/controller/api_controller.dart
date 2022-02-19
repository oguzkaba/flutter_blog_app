import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/blog_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/categories_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/toogle_favorite_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/user_login_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:flutter_blog_app/app/global/controller/internet_controller.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  UserLoginModel user = UserLoginModel();
  GetCategoriesModel categories = GetCategoriesModel();
  GetBlogsModel blogs = GetBlogsModel();
  ToggleFavoriteModel favorites = ToggleFavoriteModel();
  AccountModel account = AccountModel();

  final isLoginLoading = true.obs;
  final isGetCatLoading = true.obs;
  final isGetBlogsLoading = true.obs;
  final isToggleFavsLoading = true.obs;
  final isGetAccountLoading = true.obs;

  final token = "".obs;

  final NetController netContoller = Get.put(NetController());

  @override
  void onInit() {
    if (!netContoller.isOnline) {
      // if (localDBController.questionsData.isEmpty) {
      // } else {
      //   localDBController.getData();
      // }
    } else {}
    super.onInit();
  }

//Login method
  Future<void> login(String email, String password) async {
    try {
      isLoginLoading(true);
      user = await RemoteServices.userLogin(email, password);
      // localDBController.questionsData.addAll(user.items!
      //     .map<LocalQuestionsModel>(
      //         (e) => LocalQuestionsModel(title: e.title)));
    } finally {
      isLoginLoading(false);
    }
  }

  //Get Cateries method
  Future<void> getCategories() async {
    try {
      isGetCatLoading(true);
      categories = await RemoteServices.getCategories();
    } finally {
      isGetCatLoading(false);
    }
  }

  //Get Blogs method
  Future<void> getBlogs(String? id) async {
    try {
      isGetBlogsLoading(true);
      blogs = await RemoteServices.getBlogs(id ?? "");
    } finally {
      isGetBlogsLoading(false);
    }
  }

  //Toogle Favorites method
  Future<void> toggleFav(String id) async {
    try {
      isToggleFavsLoading(true);
      favorites = await RemoteServices.toggleFavorites(id);
    } finally {
      isToggleFavsLoading(false);
    }
  }

  //Account method
  Future<void> getAccount() async {
    try {
      isToggleFavsLoading(true);
      account = await RemoteServices.getAccounts();
    } finally {
      isToggleFavsLoading(false);
    }
  }
}
