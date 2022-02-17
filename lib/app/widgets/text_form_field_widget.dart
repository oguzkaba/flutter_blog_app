import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/constants.dart';
import 'package:get/get.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final TextInputAction action;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  TextFormFieldWidget(
      {required this.hintText,
      required this.prefixIconData,
      this.suffixIconData,
      required this.obscureText,
      required this.onChanged,
      required this.action,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .9,
      child: TextFormField(
        //autofocus: focus,
        textInputAction: action,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        cursorColor: myBlueColor,
        style: TextStyle(
          color: myDarkColor,
          // color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: myDarkColor,
              // color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
              fontSize: 16.0),
          focusColor: myBlueColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: myGreyColor, width: 1.3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: myDarkColor, width: 1.3),
          ),
          labelText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Icon(
              prefixIconData,
              size: 25,
              color: myGreyColor,
              //color: tc.isSavedDarkMode() ? Global.white : Global.dark_default,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              //lc.isVisible = !lc.isVisible;
            },
            child: Icon(
              suffixIconData,
              size: 20, color: myGreyColor,
              //color: lc.isVisible ? Global.dark_default : Global.light,
            ),
          ),
        ),
      ),
    );
  }
}
