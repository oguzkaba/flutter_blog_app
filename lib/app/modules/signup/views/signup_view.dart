import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/global/utils/responsive.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:flutter_blog_app/app/widgets/text_form_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();

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
                key:formKeyRegister,
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
      onClick: () {
        if (formKeyRegister.currentState!.validate()) {
          Get.toNamed(Routes.MAIN);
        } else {
          print("hata");
          //     Get.snackbar(
          //       'Warning..!'.tr,
          //       'User is inactive, contact your administrator'
          //           .tr, //'Kullanıcı aktif değil....',
          //       backgroundColor:myRedColor,
          //       colorText: myWhiteColor);
          // }
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
    onChanged: (value) => controller.email.value = value,
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
        controller.password.value = value;
      } else {
        controller.passwordRetry.value = value;
      }
    },
    suffixIconData:
        controller.isVisible.value ? Icons.visibility_off : Icons.visibility,
    validator: text == "Password"
        ? controller.validatePassword
        : controller.validatePasswordRetry,
  );
}
