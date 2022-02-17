import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';

class Themes {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      //scaffoldBackgroundColor: myWhiteColor,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          backgroundColor: myWhiteColor,
          titleTextStyle: TextStyle(
              color: myDarkColor, fontSize: 20, fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: myWhiteColor,
        selectedItemColor: myDarkColor,
        unselectedItemColor: myDarkColor,
        unselectedIconTheme: IconThemeData(color: myGreyColor),
        selectedIconTheme: IconThemeData(color: myDarkColor),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith();
  }
}
