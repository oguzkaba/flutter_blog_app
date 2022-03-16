import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/toogle_fav_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/article_detail/controllers/article_detail_controller.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {

  @override
  Widget build(BuildContext context) {
      final ToogleFavController toogleFavController = Get.put(ToogleFavController());
  final ArticleDetailController articleDetailController =
      Get.find();
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
        body: Obx(() => Get.find<GetAccountController>().favoriteBlog.isEmpty
            ? Center(
                child: Text("Favori Alanınız Boş",
                    style: TextStyle(fontSize: 30, color: myDarkColor)))
            : Get.find<GetAccountController>().isGetAccountLoading.value
                ? Center(child: CircularProgressIndicator(color: myDarkColor))
                : _blogArticlesGridView(articleDetailController,toogleFavController)),
      ),
    );
  }

  GridView _blogArticlesGridView(ArticleDetailController articleDetailController,ToogleFavController toogleFavController) {
    var favBlogIds = Get.find<GetAccountController>().favoriteBlog;
    var articles = Get.find<GetBlogsController>().blogs.value.data!;

    List favGetFavBlogList() {
      var favBlog = [];
      if (favBlogIds.isEmpty) {
        return favBlog = [];
      } else {
        for (var favorite in favBlogIds) {
          for (var article in articles) {
            if (favorite == article.id) {
              favBlog.add(article);
            }
          }
        }
        return favBlog;
      }
    }

    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(
            Get.find<GetAccountController>().favoriteBlog.length, (index) {
          return GestureDetector(
            onTap: () {
              articleDetailController.selectedArticle.value =
                  favGetFavBlogList()[index];
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
                          await toogleFavController.toggleFav(
                              favGetFavBlogList()[index].id,
                              PrefController().getToken());
                        },
                        icon:
                            Icon(Icons.favorite, color: myRedColor, size: 30))),
              ]),
            ),
          );
        }));
  }
}
