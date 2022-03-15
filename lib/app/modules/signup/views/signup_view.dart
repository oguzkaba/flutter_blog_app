// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/remote/controller/sign_up_controller.dart';
import 'package:flutter_blog_app/app/global/controller/network_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:flutter_blog_app/app/widgets/text_form_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  final NetworkController netContoller = Get.put(NetworkController());
  final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Obx(() => Column(children: [
                    vPaddingM,
                    _imageRegister(keyboardOpen),
                    vPaddingM,
                    Form(
                        key: _formKeyRegister,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  buildTextFormFieldWidgetEmail(controller),
                                  vPaddingS,
                                  buildTextFormFieldWidgetPass(
                                      "Password", controller),
                                  vPaddingS,
                                  buildTextFormFieldWidgetPass(
                                      "Re-Password", controller),
                                  vPaddingM,
                                  Visibility(
                                      visible: !netContoller.isOnline,
                                      child: Text("No internet connection..!",
                                          style: TextStyle(color: myRedColor))),
                                  vPaddingS,
                                  _registerButton(context),
                                  vPaddingS,
                                  _loginButton(context),
                                ])))
                  ]))),
        ));
  }

  Visibility _imageRegister(bool keyboardOpen) {
    return Visibility(
      visible: !keyboardOpen && GetPlatform.isMobile,
      child: SvgPicture.asset(
        signUpIcon,
        color: myDarkColor,
        width: Get.width * .8,
        height: Get.height * .25,
      ),
    );
  }

  ButtonWidget _loginButton(BuildContext context) {
    return ButtonWidget(
      text: "Login",
      icon: Icons.login_rounded,
      tcolor: myDarkColor,
      onClick: () {
        Get.toNamed(Routes.LOGIN);
      },
      height: Get.height * .07,
      color: myWhiteColor,
    );
  }

  ButtonWidget _registerButton(BuildContext context) {
    return ButtonWidget(
      text: "Register",
      icon: Icons.person_add_rounded,
      tcolor: myWhiteColor,
      onClick: netContoller.isOnline
          ? () async {
              if (_formKeyRegister.currentState!.validate()) {
                await signUpController
                    .signUp(controller.email.value, controller.password.value,
                        controller.passwordRetry.value)
                    .then((value) {
                  if (signUpController.newUser.value.hasError == false &&
                      controller.password.value ==
                          controller.passwordRetry.value &&
                      signUpController.isSignUpLoading.value == false) {
                    Get.offAndToNamed(Routes.MAIN);
                  } else {
                    Get.snackbar(
                        'Warning..!',
                        signUpController.newUser.value.validationErrors!.isEmpty
                            ? "${signUpController.newUser.value.message}."
                            : "${signUpController.newUser.value.validationErrors!.first["Value"] ?? ""}. ${signUpController.newUser.value.message}.",
                        backgroundColor: myRedColor,
                        colorText: myWhiteColor);
                  }
                });
              }
            }
          : () {},
      height: Get.height * .07,
      color: myDarkColor,
    );
  }
}

TextFormFieldWidget buildTextFormFieldWidgetEmail(SignupController controller) {
  return TextFormFieldWidget(
    controller: controller,
    action: TextInputAction.next,
    hintText: 'Email'.tr,
    obscureText: false,
    prefixIconData: Icons.email,
    //suffixIconData: model.isValid ? Icons.check : null,
    validator: controller.validateEmail,
    onChanged: (value) => controller.email.value = value.trim(),
  );
}

TextFormFieldWidget buildTextFormFieldWidgetPass(
    String text, SignupController controller) {
  return TextFormFieldWidget(
    controller: controller,
    action: text == "Password" ? TextInputAction.next : TextInputAction.send,
    hintText: text,
    obscureText: controller.isVisible.value ? false : true,
    prefixIconData: Icons.lock,
    onChanged: (value) {
      if (text == "Password") {
        controller.password.value = value.trim();
      } else {
        controller.passwordRetry.value = value.trim();
      }
    },
    suffixIconData:
        controller.isVisible.value ? Icons.visibility_off : Icons.visibility,
    validator: text == "Password"
        ? controller.validatePassword
        : controller.validatePasswordRetry,
  );
}
