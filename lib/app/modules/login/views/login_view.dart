import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';
import 'package:flutter_blog_app/app/global/utils/responsive.dart';
import 'package:flutter_blog_app/app/routes/app_pages.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:flutter_blog_app/app/widgets/text_form_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
    GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>(debugLabel: "login");
  @override
  Widget build(BuildContext context) {
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
                key: _formKeyLogin,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildTextFormFieldWidgetEmail(controller),
                              vPaddingS,
                              buildTextFormFieldWidgetPass(controller),
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
        if (_formKeyLogin.currentState!.validate()) {
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
      // widget: dvc.loginLoading.value
      //     ? LoadingWidget(color: Global.white)
      //     : Text('Login'.tr,
      //         style:
      //             TextStyle(color: Global.white, fontSize: 18)),
    );
  }
}

TextFormFieldWidget buildTextFormFieldWidgetEmail(LoginController controller) {
  return TextFormFieldWidget(
    controller: controller,
    action: TextInputAction.next,
    hintText: 'Email',
    obscureText: false,
    prefixIconData: Icons.email,
    //suffixIconData: model.isValid ? Icons.check : null,
    onChanged: (value) => controller.email.value = value,
    validator: controller.validateEmail,
  );
}

TextFormFieldWidget buildTextFormFieldWidgetPass(LoginController controller) {
  return TextFormFieldWidget(
      controller: controller,
      action: TextInputAction.send,
      hintText: 'Password',
      obscureText: controller.isVisible.value ? false : true,
      prefixIconData: Icons.lock,
      suffixIconData:
          controller.isVisible.value ? Icons.visibility_off : Icons.visibility,
      validator: controller.validatePassword,
      onChanged: (value) => controller.password.value = value);
}
