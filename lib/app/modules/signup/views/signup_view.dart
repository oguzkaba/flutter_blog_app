// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/data/local/local_storage_controller.dart';
import 'package:flutter_blog_app/app/data/remote/controller/api_controller.dart';
import 'package:flutter_blog_app/app/global/controller/internet_controller.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/global/utils/responsive.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:flutter_blog_app/app/widgets/text_form_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final GlobalKey<FormState> _formKeyRegister = GlobalKey<FormState>();
  final NetController netContoller = Get.put(NetController());
  final ApiController apiController = Get.put(ApiController());
  final PrefController prefController = Get.put(PrefController());

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(Get.context!).viewInsets.bottom > 0;

    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            vPaddingM,
            _imageRegister(keyboardOpen),
            vPaddingM,
            Form(
                key: _formKeyRegister,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Obx(() => Column(
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
                              _registerButton(context),
                              vPaddingS,
                              _loginButton(context),
                            ]))))
          ])),
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
      width: Responsive.isMobile(context) ? Get.width * .9 : Get.width * .3,
      height: Get.height * .07,
      color: myWhiteColor,
    );
  }

  ButtonWidget _registerButton(BuildContext context) {
    return ButtonWidget(
      text: "Register",
      icon: Icons.person_add_rounded,
      tcolor: myWhiteColor,
      onClick: () async {
        if (_formKeyRegister.currentState!.validate()) {
          await apiController
              .signUp(controller.email.value, controller.password.value,
                  controller.passwordRetry.value)
              .whenComplete(() async {
            await apiController.login(
                controller.email.value, controller.password.value);
            if (apiController.user.hasError == false &&
                controller.password.value == controller.passwordRetry.value &&
                apiController.isSignUpLoading.value == false) {
              //apiController.token = apiController.user.data!.token!;
              prefController.token.value = apiController.user.data!.token!;
              prefController.isLogin.value = true;
              prefController.saveToPrefs();
              Get.offAndToNamed(Routes.MAIN);
            } else {
              Get.snackbar(
                  'Warning..!',
                  apiController.user.validationErrors!.isEmpty
                      ? "${apiController.user.message}."
                      : "${apiController.user.validationErrors!.first["Value"] ?? ""}. ${apiController.user.message}.",
                  backgroundColor: myRedColor,
                  colorText: myWhiteColor);
            }
          });
        }
      },
      width: Responsive.isMobile(context) ? Get.width * .9 : Get.width * .3,
      height: Get.height * .07,
      color: myDarkColor,
      // onClick: _loginButtonPress(
      //     dvc, lc, apic, sc, _isButtonDisabled),
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
