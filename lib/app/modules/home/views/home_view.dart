import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search_rounded, color: myDarkColor, size: 28),
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
              child: Obx(() => _categoriesListView()),
            ),
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
              child: Obx(() => _blogArticlesGridView()),
            ),
          ],
        ),
      ),
    );
  }

  GridView _blogArticlesGridView() {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(controller.blogsItem.length, (index) {
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
                  controller.blogsItem[index].image,
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
                      child: Text(controller.blogsItem[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: myDarkColor))),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Obx(() => IconButton(
                      onPressed: () async {
                        await apiController
                            .toggleFav(controller.blogsItem[index].id);
                      },
                      icon: Icon(Icons.favorite,
                          color: controller.indexFav.contains(index)
                              ? myRedColor
                              : myWhiteColor,
                          size: 30))),
                )
              ]),
            ),
          );
        }));
  }

  ListView _categoriesListView() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: controller.categoriesItem.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => apiController
            .getBlogs(controller.categoriesItem[index].id)
            .then((value) =>
                controller.blogsItem.value = apiController.blogs.data!),
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
                  child: Image.network(controller.categoriesItem[index].image,
                      fit: BoxFit.cover, width: Get.width * .42),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(controller.categoriesItem[index].title!,
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
