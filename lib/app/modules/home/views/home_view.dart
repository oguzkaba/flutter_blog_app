import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/article_detail/controllers/article_detail_controller.dart';
import 'package:flutter_blog_app/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ArticleDetailController artDetController =
      Get.put(ArticleDetailController());
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
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
                child: GetX<ApiController>(
                    init: ApiController(),
                    initState: (_) {},
                    builder: (_) => _.isGetCatLoading.value
                        ? Center(
                            child:
                                CircularProgressIndicator(color: myDarkColor))
                        : _categoriesListView(_))),
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
              child: GetX<ApiController>(
                  init: ApiController(),
                  initState: (_) {},
                  builder: (_) => _.isGetBlogsLoading.value
                      ? Center(
                          child: CircularProgressIndicator(color: myDarkColor))
                      : _blogArticlesGridView(_)),
            ),
          ],
        ),
      ),
    );
  }

  GridView _blogArticlesGridView(ApiController _) {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(_.blogs.value.data!.length, (index) {
          return GestureDetector(
            onTap: () {
              artDetController.selectedArticle.value =
                  _.blogs.value.data![index];
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
                  _.blogs.value.data![index].image!,
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
                      child: Text(_.blogs.value.data![index].title!,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: myDarkColor))),
                ),
                _favButton(index, _)
              ]),
            ),
          );
        }));
  }

  Widget _favButton(int index, ApiController _) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
          onPressed: () async {
            await _.toggleFav(_.blogs.value.data![index].id!);
          },
          icon: Icon(Icons.favorite,
              color: favoritesController.favoriteBlogs
                      .contains(_.blogs.value.data![index].id)
                  ? myRedColor
                  : myWhiteColor,
              size: 30)),
    );
  }

  ListView _categoriesListView(ApiController _) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _.categories.value.data!.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => _.getBlogs(_.categories.value.data![index].id),
        // .then((value) => apiController.categories.value =
        //     apiController.blogs.value.data),
        child: SizedBox(
          width: Get.width * .42,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Card(
                  margin: EdgeInsets.all(5),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Image.network(_.categories.value.data![index].image!,
                      fit: BoxFit.cover, width: Get.width * .42),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(_.categories.value.data![index].title!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
