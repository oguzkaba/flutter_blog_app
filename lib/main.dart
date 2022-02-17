import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog_app/app/themes/theme.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //orientation config
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Blog App",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: Themes.lightTheme()),
  );
}
