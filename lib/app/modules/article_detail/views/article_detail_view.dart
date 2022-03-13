// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/get_account_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/toogle_fav_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';
import '../controllers/article_detail_controller.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  @override
  Widget build(BuildContext context) {
    final ArticleDetailController articleDetailController = Get.put(ArticleDetailController());
    final ToogleFavController favController = Get.put(ToogleFavController());
    final GetAccountController getAccountController = Get.find();

    return WillPopScope(
      onWillPop: () async {
        Get.find<MainController>()
            .pageindex(Get.find<MainController>().pIndex.value);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.chevron_left_rounded,
                    color: myDarkColor, size: 35),
                onPressed: () => Get.find<MainController>()
                    .pageindex(Get.find<MainController>().pIndex.value)),
            title: Text('Article Detail'),
            centerTitle: true,
            actions: [
              Obx(() => IconButton(
                    icon: Icon(
                        getAccountController.account.value.data!.favoriteBlogIds
                                .contains(articleDetailController.selectedArticle.value.id!)
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: myDarkColor,
                        size: 30),
                    onPressed: () async {
                      await favController.toggleFav(
                          articleDetailController.selectedArticle.value.id!,
                          PrefController().getToken());
                    },
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(articleDetailController.selectedArticle.value.title.toString(),
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                        width: Get.width * .9, child: Divider(thickness: 2))
                  ],
                )),
                Expanded(
                    flex: 5,
                    child: Image.network(
                        articleDetailController.selectedArticle.value.image.toString())),
                Expanded(
                    flex: 6,
                    child: HtmlWidget(
                        articleDetailController.selectedArticle.value.content.toString(),
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis))),
              ],
            ),
          )),
    );
  }
}
