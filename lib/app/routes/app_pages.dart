// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:flutter_blog_app/app/modules/article_detail/bindings/article_detail_binding.dart';
import 'package:flutter_blog_app/app/modules/article_detail/views/article_detail_view.dart';
import 'package:flutter_blog_app/app/modules/favorites/bindings/favorites_binding.dart';
import 'package:flutter_blog_app/app/modules/favorites/views/favorites_view.dart';
import 'package:flutter_blog_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blog_app/app/modules/home/views/home_view.dart';
import 'package:flutter_blog_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blog_app/app/modules/login/views/login_view.dart';
import 'package:flutter_blog_app/app/modules/main/bindings/main_binding.dart';
import 'package:flutter_blog_app/app/modules/main/views/main_view.dart';
import 'package:flutter_blog_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:flutter_blog_app/app/modules/profile/views/profile_view.dart';
import 'package:flutter_blog_app/app/modules/signup/bindings/signup_binding.dart';
import 'package:flutter_blog_app/app/modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_DETAIL,
      page: () => ArticleDetailView(),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
  ];
}
