import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/constants.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  final Widget? widget;
  final String text;
  final Color? color;
  final Color? tcolor;
  final void Function()? onClick;
  final double? width;
  final double? height;

  const ButtonWidget(
      {Key? key,
      this.widget,
      required this.text,
      this.color,
      this.onClick,
      this.height,
      this.width,
      this.tcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.height * .09,
      width: width ?? Get.width * .3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: myTrnsprntColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: myDarkColor),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          //shadowColor: Colors.transparent,
          primary: color,
        ),
        onPressed: onClick,
        child: widget ??
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.login_rounded,
                      color: text == "Login" ? myWhiteColor : myDarkColor),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(text,
                      style: TextStyle(
                          color: text == "Login" ? myWhiteColor : myDarkColor,
                          fontSize: 18)),
                ),
              ],
            ),
      ),
    );
  }
}
