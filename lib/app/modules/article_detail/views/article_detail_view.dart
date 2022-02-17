import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded, color: myDarkColor, size: 35),
          onPressed: () => Get.find<MainController>().pageindex(1),
        ),
        title: Text('Article Detail'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_rounded, color: myDarkColor, size: 30),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Text(
          'ArticleDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
