import 'dart:io';

import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_update_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/blog_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/categories_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/sign_up_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/toogle_favorite_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/login_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/upload_image_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
import 'package:flutter_blog_app/app/global/controller/internet_controller.dart';
import 'package:flutter_blog_app/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  UserLoginModel user = UserLoginModel();
  GetCategoriesModel categories = GetCategoriesModel();
  GetBlogsModel blogs = GetBlogsModel();
  GetBlogsModel allBlogs = GetBlogsModel();
  ToggleFavoriteModel favorites = ToggleFavoriteModel();
  AccountModel account = AccountModel();
  AccountUpdateModel upAccount = AccountUpdateModel();
  SignUpModel newUser = SignUpModel();
  UploadImageModel uploadImage=UploadImageModel();

  final categoriesItem = [].obs;
  final blogsItem = [].obs;
  final allBlogsItem = [].obs;
  final toogleFav = false.obs;
  final accountItem = [].obs;
  final favoriteBlogList = [].obs;

  final isLoginLoading = true.obs;
  final isGetCatLoading = true.obs;
  final isGetBlogsLoading = true.obs;
  final isToggleFavsLoading = true.obs;
  final isGetAccountLoading = true.obs;
  final isSignUpLoading = true.obs;
  final isUploadImageLoading = true.obs;
  

  final token = "".obs;

  final NetController netContoller = Get.put(NetController());
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  @override
  void onInit() async {
    await getAllBlogs();
    await getCategories();
    await getAccount();

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
    } finally {
      // localDBController.questionsData.addAll(user.items!
      //     .map<LocalQuestionsModel>(
      //         (e) => LocalQuestionsModel(title: e.title)));
      isLoginLoading(false);
    }
  }

//Login method
  Future<void> signUp(String email, String password, String password2) async {
    try {
      isSignUpLoading(true);
      newUser = await RemoteServices.signUp(email, password, password2);
    } finally {
      login(email, password);
      // localDBController.questionsData.addAll(user.items!
      //     .map<LocalQuestionsModel>(
      //         (e) => LocalQuestionsModel(title: e.title)));
      isSignUpLoading(false);
    }
  }

  //Account method
  Future<void> getAccount() async {
    try {
      isGetAccountLoading(true);
      account = await RemoteServices.getAccounts();
    } finally {
      if (account.data!.favoriteBlogIds.isEmpty) {
        accountItem.value = [];
      } else {
        accountItem.value = account.data!.favoriteBlogIds;
      }
      favGetFavBlogList();
      isGetAccountLoading(false);
    }
  }

  //UpdateAccount method
  Future<void> updateAccount(img, lng, ltd) async {
    try {
      upAccount = await RemoteServices.updateAccounts(img, lng, ltd);
    } finally {
      getAccount();
      isGetAccountLoading(false);
    }
  }

  //Get Categories method
  Future<void> getCategories() async {
    try {
      isGetCatLoading(true);
      categories = await RemoteServices.getCategories();
    } finally {
      categoriesItem.value = categories.data!;

      isGetCatLoading(false);
    }
  }

  //Get Blogs method
  Future<void> getBlogs(String? id) async {
    try {
      isGetBlogsLoading(true);
      blogs = await RemoteServices.getBlogs(id ?? "");
    } finally {
      blogsItem.value = blogs.data!;
      isGetBlogsLoading(false);
    }
  }

  //Get AllBlogs method
  Future<void> getAllBlogs() async {
    try {
      isGetBlogsLoading(true);
      allBlogs = await RemoteServices.getBlogs("");
    } finally {
      allBlogsItem.value = allBlogs.data!;
      blogsItem.value = allBlogs.data!;
      isGetBlogsLoading(false);
    }
  }

  //Toogle Favorites method
  Future<void> toggleFav(String id) async {
    try {
      isToggleFavsLoading(true);
      favorites = await RemoteServices.toggleFavorites(id);
    } finally {
      await getAccount();
      isToggleFavsLoading(false);
    }
  }

  //Upload Image method
  Future<void> uploadImageApi(File file, String filename) async {
    try {
      isUploadImageLoading(true);
      uploadImage= await RemoteServices.uploadImage(file,filename);
      getAccount();
    } finally {
      await getAccount();
      isUploadImageLoading(false);
    }
  }

//Favorite List
  favGetFavBlogList() {
    favoriteBlogList.clear();
    for (var favorite in accountItem) {
      for (var article in allBlogsItem) {
        if (favorite == article.id) {
          favoriteBlogList.add(article);
        }
      }
    }
  }
}
