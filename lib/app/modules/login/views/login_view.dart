import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/constants.dart';
import 'package:flutter_blog_app/app/widgets/elevated_button_widget.dart';
import 'package:flutter_blog_app/app/widgets/text_form_field_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            vPaddingM,
            SvgPicture.asset(
              loginIcon,
              color: myDarkColor,
              width: Get.width * .8,
              height: Get.height * .25,
            ),
            vPaddingM,
            Form(
                //TODO: Add key from controller
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildTextFormFieldWidgetEmail(),
                          vPaddingS,
                          buildTextFormFieldWidgetPass(),
                          vPaddingM,
                          ButtonWidget(
                            text: "Login",
                            tcolor: myWhiteColor,
                            onClick: () {},
                            width: Get.width * .9,
                            // width: Responsive.isMobile(context)
                            //     ? Get.width * .9
                            //     : Get.width * .3,
                            //height: Get.height * .06,
                            color: myDarkColor,
                            // onClick: _loginButtonPress(
                            //     dvc, lc, apic, sc, _isButtonDisabled),
                            // widget: dvc.loginLoading.value
                            //     ? LoadingWidget(color: Global.white)
                            //     : Text('Login'.tr,
                            //         style:
                            //             TextStyle(color: Global.white, fontSize: 18)),
                          ),
                          vPaddingS,
                          ButtonWidget(
                            text: "Register",
                            tcolor: myWhiteColor,
                            onClick: () {},
                            width: Get.width * .9,
                            // width: Responsive.isMobile(context)
                            //     ? Get.width * .9
                            //     : Get.width * .3,
                            //height: Get.height * .06,
                            color: myTrnsprntColor,

                            // onClick: _loginButtonPress(
                            //     dvc, lc, apic, sc, _isButtonDisabled),
                            // widget: dvc.loginLoading.value
                            //     ? LoadingWidget(color: Global.white)
                            //     : Text('Login'.tr,
                            //         style:
                            //             TextStyle(color: Global.white, fontSize: 18)),
                          ),
                        ])))
          ])),
        ));
  }
}

TextFormFieldWidget buildTextFormFieldWidgetEmail() {
  return TextFormFieldWidget(
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

TextFormFieldWidget buildTextFormFieldWidgetPass() {
  return TextFormFieldWidget(
    action: TextInputAction.send,
    hintText: 'Password'.tr,
    //obscureText: lc.isVisible ? false : true,
    prefixIconData: Icons.lock, obscureText: true, onChanged: (value) {},
    suffixIconData: Icons.visibility,
    //suffixIconData: lc.isVisible ? Icons.visibility : Icons.visibility_off,
    //validator: lc.validatePassword,
    //onChanged: (value) => lc.onSavedPassword(value),
  );
}
