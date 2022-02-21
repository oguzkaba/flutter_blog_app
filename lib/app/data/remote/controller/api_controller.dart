import 'dart:io';

import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_update_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/blog_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/categories_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/sign_up_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/toogle_favorite_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/login_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/upload_image_model.dart';
import 'package:flutter_blog_app/app/data/remote/service/remote_services.dart';
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
  UploadImageModel uploadImage = UploadImageModel();

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

  final logout = false.obs;
  var token = "";

  final PrefController prefController = Get.put(PrefController());
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  @override
  void onInit() async {
    //preff
    getToken();
    super.onInit();
  }

  getToken() async {
    if (prefController.token.value != "") {
      token = prefController.token.value;
      await _initLoad();
    } else {
      token = user.data!.token!;
      await _initLoad();
    }
  }

  _logoutClear() {}

  _initLoad() async {
    await getAllBlogs();
    await getCategories();
    await getAccount();
  }

//Login method
  Future<void> login(String email, String password) async {
    token = "";
    try {
      isLoginLoading(true);
      user = await RemoteServices.userLogin(email, password);
    } finally {
      token = user.data!.token!;
      await getAccount();
      isLoginLoading(false);
    }
  }

//SignUp method
  Future<void> signUp(String email, String password, String password2) async {
    try {
      isSignUpLoading(true);
      newUser = await RemoteServices.signUp(email, password, password2);
    } finally {
      await login(email, password).whenComplete(() => getAccount());

      isSignUpLoading(false);
    }
  }

  //Account method
  Future<void> getAccount() async {
    try {
      isGetAccountLoading(true);
      account = await RemoteServices.getAccounts(token);
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
      upAccount = await RemoteServices.updateAccounts(
          img, lng.toString(), ltd.toString(), token);
    } finally {
      await getAccount();
      isGetAccountLoading(false);
    }
  }

  //Get Categories method
  Future<void> getCategories() async {
    try {
      isGetCatLoading(true);
      categories = await RemoteServices.getCategories(token);
    } finally {
      categoriesItem.value = categories.data!;
      isGetCatLoading(false);
    }
  }

  //Get Blogs method
  Future<void> getBlogs(String? id) async {
    try {
      isGetBlogsLoading(true);
      blogs = await RemoteServices.getBlogs(id ?? "", token);
    } finally {
      blogsItem.value = blogs.data!;
      isGetBlogsLoading(false);
    }
  }

  //Get AllBlogs method
  Future<void> getAllBlogs() async {
    try {
      isGetBlogsLoading(true);
      allBlogs = await RemoteServices.getBlogs("", token);
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
      favorites = await RemoteServices.toggleFavorites(id, token);
    } finally {
      await getAccount();
      isToggleFavsLoading(false);
    }
  }

  //Upload Image method
  Future<void> uploadImageApi(File file, String filename) async {
    try {
      isUploadImageLoading(true);
      uploadImage = await RemoteServices.uploadImage(file, filename, token);
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
