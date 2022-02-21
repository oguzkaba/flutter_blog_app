import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());
  final ApiController apiController = Get.put(ApiController());

  List favGetFavBlogList() {
    var favoriteBlog = [];
    for (var favorite in apiController.account.value.data!.favoriteBlogIds) {
      for (var article in apiController.blogs.value.data!) {
        if (favorite == article.id) {
          favoriteBlog.add(article);
        }
      }
    }
    return favoriteBlog;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<MainController>().pageindex(1);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
                Icon(Icons.chevron_left_rounded, color: myDarkColor, size: 35),
            onPressed: () => Get.find<MainController>().pageindex(1),
          ),
          title: Text('My Favorites'),
          centerTitle: true,
        ),
        body: Obx(() => controller.favoriteBlogs.isEmpty
            ? Center(
                child: Text("Favori Alanınız Boş",
                    style: TextStyle(fontSize: 30, color: myDarkColor)))
            : apiController.isGetAccountLoading.value
                ? Center(child: CircularProgressIndicator(color: myDarkColor))
                : _blogArticlesGridView()),
      ),
    );
  }

  GridView _blogArticlesGridView() {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(controller.favoriteBlogs.length, (index) {
          return GestureDetector(
            onTap: () {
              Get.find<MainController>().pController.jumpToPage(3);
            },
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(fit: StackFit.passthrough, children: [
                Image.network(
                  favGetFavBlogList()[index].image!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                      height: 40,
                      width: 200,
                      color: myWhiteColor.withOpacity(0.7),
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: Text(favGetFavBlogList()[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: myDarkColor))),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () async {
                          await apiController
                              .toggleFav(favGetFavBlogList()[index].id);
                        },
                        icon:
                            Icon(Icons.favorite, color: myRedColor, size: 30))),
              ]),
            ),
          );
        }));
  }
}
