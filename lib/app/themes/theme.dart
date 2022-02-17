import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/constants.dart';

class Themes {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          backgroundColor: myWhiteColor,
          titleTextStyle: TextStyle(
              color: myDarkColor, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith();
  }
}
