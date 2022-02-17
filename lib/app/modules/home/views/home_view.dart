import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          vPaddingS,
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Category Tag-${index + 1}'),
                )),
              ),
            ),
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
            child: GridView.count(
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
                })),
          ),
        ],
      ),
    );
  }
}
