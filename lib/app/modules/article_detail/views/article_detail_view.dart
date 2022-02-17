import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArticleDetailView'),
        centerTitle: true,
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
