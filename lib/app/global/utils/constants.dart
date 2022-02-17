import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/modules/article_detail/views/article_detail_view.dart';
import 'package:flutter_blog_app/app/modules/favorites/views/favorites_view.dart';
import 'package:flutter_blog_app/app/modules/home/views/home_view.dart';
import 'package:flutter_blog_app/app/modules/profile/views/profile_view.dart';

///
///API-End Point
///

///
///Constant variables
///
//Color
const Color myDarkColor = Color(0xff292f3b);
const Color myWhiteColor = Color(0xffffffff);
const Color myShadowColor = Color.fromARGB(255, 163, 163, 163);
const Color myDarkGreyColor = Color(0xff2c2c2c);
const Color myGreyColor = Color(0xFFBEBEBE);
const Color myCardColor = Color(0xFFE9E9E9);
const Color myRedColor = Color(0xFFAA2929);
const Color myGreenColor = Color(0xFF29AA79);
const Color myTrnsprntColor = Colors.transparent;

//Assets
//
const loginIcon = "assets/images/login.svg";
const signUpIcon = "assets/images/register.svg";

///Pages List
///
final List<Widget> pages = [
  FavoritesView(),
  HomeView(),
  ProfileView(),
  ArticleDetailView()
];

//Padding
///Vertical
const Padding vPaddingS = Padding(padding: EdgeInsets.symmetric(vertical: 5));
const Padding vPaddingM = Padding(padding: EdgeInsets.symmetric(vertical: 15));
const Padding vPaddingL = Padding(padding: EdgeInsets.symmetric(vertical: 25));
const Padding vPaddingXL = Padding(padding: EdgeInsets.symmetric(vertical: 35));

///Horizontal
const Padding hPaddingS = Padding(padding: EdgeInsets.symmetric(horizontal: 5));
const Padding hPaddingM =
    Padding(padding: EdgeInsets.symmetric(horizontal: 15));
