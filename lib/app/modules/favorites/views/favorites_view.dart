import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
                Icon(Icons.chevron_left_rounded, color: myDarkColor, size: 35),
            onPressed: () => Get.find<MainController>().pageindex(1),
          ),
          title: Text('My Favorites'),
          centerTitle: true,
        ),
        body: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(30, (index) {
              return GestureDetector(
                onTap: () {
                  Get.find<MainController>().pController.jumpToPage(3);
                },
                child: Card(
                  child: Center(child: Text("Article ${index + 1}")),
                ),
              );
            })));
  }
}
