import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_blogs_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_categories_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/toogle_fav_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/article_detail/controllers/article_detail_controller.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final GetAccountController getAccountController = Get.find();
    final ArticleDetailController articleDetailController =
        Get.put(ArticleDetailController());
    final ToogleFavController toogleFavController =
        Get.put(ToogleFavController());
    final GetBlogsController getBlogsController = Get.find();
    final GetBlogsController getBlogsController2 =
        Get.put(GetBlogsController(), tag: "selectCategory");
    final GetCategoriesController getCategoriesController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.accessibility_new_sharp, color: myDarkColor, size: 28),
          onPressed: () {},
        ),
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            vPaddingS,
            Expanded(
                flex: 1,
                child: Obx(() => getCategoriesController.isGetCatLoading.value
                    ? Center(
                        child: CircularProgressIndicator(color: myDarkColor))
                    : _categoriesListView(
                        getCategoriesController, getBlogsController2))),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Blog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Obx(() => getBlogsController.isGetBlogsLoading.value
                  ? Center(child: CircularProgressIndicator(color: myDarkColor))
                  : _blogArticlesGridView(
                      getBlogsController2.blogs.value.data != null
                          ? getBlogsController2
                          : getBlogsController,
                      articleDetailController,
                      getAccountController,
                      toogleFavController)),
            ),
          ],
        ),
      ),
    );
  }

  GridView _blogArticlesGridView(
      GetBlogsController gb,
      ArticleDetailController articleDetailController,
      GetAccountController getAccountController,
      ToogleFavController toogleFavController) {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(gb.blogs.value.data!.length, (index) {
          return GestureDetector(
            onTap: () async {
              articleDetailController.selectedArticle.value =
                  gb.blogs.value.data![index];
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
                  gb.blogs.value.data![index].image!,
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
                      child: Text(gb.blogs.value.data![index].title!,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: myDarkColor))),
                ),
                _favButton(index, gb, getAccountController, toogleFavController)
              ]),
            ),
          );
        }));
  }

  Widget _favButton(
      int index,
      GetBlogsController gb,
      GetAccountController getAccountController,
      ToogleFavController toogleFavController) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
          onPressed: () async {
            await toogleFavController.toggleFav(
                gb.blogs.value.data![index].id!, PrefController().getToken());
          },
          icon: Icon(Icons.favorite,
              color: getAccountController.isGetAccountLoading.value
                  ? myTrnsprntColor
                  : getAccountController.favoriteBlog
                          .contains(gb.blogs.value.data![index].id)
                      ? myRedColor
                      : myWhiteColor,
              size: 30)),
    );
  }

  ListView _categoriesListView(
      GetCategoriesController gc, GetBlogsController gb) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: gc.categories.value.data!.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          gc.selectedCategory.value = index;
          gb.getBlogs(
              gc.categories.value.data![index].id, PrefController().getToken());
        },
        child: SizedBox(
          width: Get.width * .42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Obx(() => Card(
                      shadowColor: Colors.deepPurple,
                      margin: EdgeInsets.all(5),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: index == gc.selectedCategory.value ? 5 : 0,
                      child: Image.network(
                          gc.categories.value.data![index].image!,
                          fit: BoxFit.cover,
                          width: Get.width * .42),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Obx(() => Text(gc.categories.value.data![index].title!,
                      textAlign: TextAlign.center,
                      style: index == gc.selectedCategory.value
                          ? TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)
                          : TextStyle(),
                      overflow: TextOverflow.ellipsis)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
