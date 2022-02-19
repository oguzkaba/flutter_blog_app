import 'dart:convert';

import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/blog_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/categories_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/toogle_favorite_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/user_login_model.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  ///Login
  static Future<UserLoginModel> userLogin(String email, String password) async {
    Map data = {
      'Email': email,
      'Password': password,
    };
    final response = await http.post(Uri.parse(baseUrl + '/Login/SignIn'),
        headers: {"Content-Type": "application/json", "accept": "*/*"},
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return userLoginModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Get Categories
  static Future<GetCategoriesModel> getCategories() async {
    final response =
        await http.get(Uri.parse(baseUrl + '/Blog/GetCategories'), headers: {
      "Content-Type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer $testToken"
    });

    if (response.statusCode == 200) {
      return getCategoriesModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Get Blogs
  static Future<GetBlogsModel> getBlogs(String id) async {
    Map data = {
      'CategoryId': id,
    };
    final response = await http.post(Uri.parse(baseUrl + '/Blog/GetBlogs'),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $testToken"
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return getBlogsModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Toogle Favorites
  static Future<ToggleFavoriteModel> toggleFavorites(String id) async {
    Map data = {
      'Id': id,
    };
    final response =
        await http.post(Uri.parse(baseUrl + '/Blog/ToggleFavorite'),
            headers: {
              "Content-Type": "application/json",
              "accept": "*/*",
              "Authorization": "Bearer $testToken"
            },
            body: jsonEncode(data));
    if (response.statusCode == 200) {
      return toggleFavoriteModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Get Acoount
  static Future<AccountModel> getAccounts() async {
    final response =
        await http.get(Uri.parse(baseUrl + '/Blog/ToggleFavorite'), headers: {
      "Content-Type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer $testToken"
    });
    if (response.statusCode == 200) {
      return accountModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }
}
