import 'dart:convert';
import 'dart:io';

import 'package:flutter_blog_app/app/data/remote/model/account_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/account_update_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/blog_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/categories_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/sign_up_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/toogle_favorite_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/login_model.dart';
import 'package:flutter_blog_app/app/data/remote/model/upload_image_model.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  ///Login
  static Future<SignUpModel> signUp(
      String email, String password, String password2) async {
    Map data = {
      'Email': email,
      'Password': password,
      'PasswordRetry': password2
    };
    final response = await http.post(Uri.parse(baseUrl + '/Login/SignUp'),
        headers: {"Content-Type": "application/json", "accept": "*/*"},
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return signUpModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Get Categories
  static Future<GetCategoriesModel> getCategories(String token) async {
    final response =
        await http.get(Uri.parse(baseUrl + '/Blog/GetCategories'), headers: {
      "Content-Type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      return getCategoriesModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Get Blogs
  static Future<GetBlogsModel> getBlogs(String id,String token) async {
    Map data = {
      'CategoryId': id,
    };
    final response = await http.post(Uri.parse(baseUrl + '/Blog/GetBlogs'),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return getBlogsModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Toogle Favorites
  static Future<ToggleFavoriteModel> toggleFavorites(String id,String token) async {
    Map data = {
      'Id': id,
    };
    final response =
        await http.post(Uri.parse(baseUrl + '/Blog/ToggleFavorite'),
            headers: {
              "Content-Type": "application/json",
              "accept": "*/*",
              "Authorization": "Bearer $token"
            },
            body: jsonEncode(data));
    if (response.statusCode == 200) {
      return toggleFavoriteModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Get Account
  static Future<AccountModel> getAccounts(String token) async {
    final response =
        await http.get(Uri.parse(baseUrl + '/Account/Get'), headers: {
      "Content-Type": "application/json",
      "accept": "*/*",
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      return accountModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Update Account
  static Future<AccountUpdateModel> updateAccounts(
      String? image, String? lng, String? ltd,String token) async {
    Map data = {
      "Image": image??"string",
      "Location": {"Longtitude": lng, "Latitude": ltd}
    };
    final response = await http.post(Uri.parse(baseUrl + '/Account/Update'),
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return accountUpdateModelFromJson(response.body);
    } else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }

  ///Upload Image
  static Future<UploadImageModel> uploadImage(
      File file, String filename,String token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl + '/General/UploadImage'),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'File',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    final http.StreamedResponse response = await request.send();
    String? data;
    await for (String s in response.stream.transform(utf8.decoder)) {
      data=s;
    }
    if (response.statusCode == 200) {
      return uploadImageModelFromJson(data!);
    }else if(response.statusCode ==413){
      throw ("Yüksek yükleme boyutu: ${response.statusCode}");
    }
     else {
      throw ("İstek durumu başarısız oldu: ${response.statusCode}");
    }
  }
}
