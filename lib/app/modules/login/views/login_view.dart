import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/global/controller/global_controller.dart';
import 'package:flutter_blog_app/app/global/utils/responsive.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:flutter_blog_app/app/widgets/text_form_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());
    final keyboardOpen = MediaQuery.of(Get.context!).viewInsets.bottom > 0;

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            vPaddingM,
            _imageLogin(keyboardOpen),
            vPaddingM,
            Form(
                //TODO: Add key from controller
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildTextFormFieldWidgetEmail(globalController),
                              vPaddingS,
                              buildTextFormFieldWidgetPass(globalController),
                              vPaddingM,
                              _loginButton(context),
                              vPaddingS,
                              _registerButton(context),
                            ]))))
          ])),
        ));
  }

  Visibility _imageLogin(bool keyboardOpen) {
    return Visibility(
      visible: !keyboardOpen && GetPlatform.isMobile,
      child: SvgPicture.asset(
        loginIcon,
        color: myDarkColor,
        width: Get.width * .8,
        height: Get.height * .25,
      ),
    );
  }

  ButtonWidget _registerButton(BuildContext context) {
    return ButtonWidget(
      text: "Register",
      icon: Icons.person_add_rounded,
      tcolor: myDarkColor,
      onClick: () {
        Get.toNamed(Routes.SIGNUP);
      },
      width: Responsive.isMobile(context) ? Get.width * .9 : Get.width * .3,
      height: Get.height * .07,
      color: myWhiteColor,

      // onClick: _loginButtonPress(
      //     dvc, lc, apic, sc, _isButtonDisabled),
      // widget: dvc.loginLoading.value
      //     ? LoadingWidget(color: Global.white)
      //     : Text('Login'.tr,
      //         style:
      //             TextStyle(color: Global.white, fontSize: 18)),
    );
  }

  ButtonWidget _loginButton(BuildContext context) {
    return ButtonWidget(
      text: "Login",
      icon: Icons.login_rounded,
      tcolor: myWhiteColor,
      onClick: () {
        Get.toNamed(Routes.MAIN);
      },
      width: Responsive.isMobile(context) ? Get.width * .9 : Get.width * .3,
      height: Get.height * .07,
      color: myDarkColor,
      // onClick: _loginButtonPress(
      //     dvc, lc, apic, sc, _isButtonDisabled),
      // widget: dvc.loginLoading.value
      //     ? LoadingWidget(color: Global.white)
      //     : Text('Login'.tr,
      //         style:
      //             TextStyle(color: Global.white, fontSize: 18)),
    );
  }
}

TextFormFieldWidget buildTextFormFieldWidgetEmail(GlobalController gc) {
  return TextFormFieldWidget(
    controller: gc,
    action: TextInputAction.next,
    hintText: 'Email'.tr,
    obscureText: false,
    prefixIconData: Icons.email,
    //suffixIconData: model.isValid ? Icons.check : null,
    //validator: lc.validateUname,
    //onChanged: (value) => lc.onSavedUname(value),
    onChanged: (value) {},
  );
}

TextFormFieldWidget buildTextFormFieldWidgetPass(GlobalController gc) {
  return TextFormFieldWidget(
    controller: gc,
    action: TextInputAction.send,
    hintText: 'Password'.tr,
    obscureText: gc.isVisible ? false : true,
    prefixIconData: Icons.lock, onChanged: (value) {},
    suffixIconData: gc.isVisible ? Icons.visibility_off : Icons.visibility,
    //validator: lc.validatePassword,
    //onChanged: (value) => lc.onSavedPassword(value),
  );
}
