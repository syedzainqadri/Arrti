import 'package:apni_mandi/controllers/auth_controller.dart';
import 'package:apni_mandi/utils/constants/assets_manager.dart';
import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:apni_mandi/utils/helpers/text_helper.dart';
import 'package:apni_mandi/views/login/components/login_no_account_text.dart';
import 'package:apni_mandi/views/login/components/social_card.dart';
import 'package:apni_mandi/widgets/large_button.dart';
import 'package:apni_mandi/widgets/password_field.dart';
import 'package:apni_mandi/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final Function toggleView;
  LoginScreen({Key? key, required this.toggleView}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _passwordVisibleOne = false;

   final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(9.h),
              Center(
                  child: textStyle7(
                      StringsManager.welcome,
                      TextAlign.center,
                      ColorManager.primaryColor),
              ),
              buildSpaceVertical(1.5.h),
              Center(
                  child: textStyle2(
                      StringsManager.loginText,
                      TextAlign.center,
                      ColorManager.grayColor),
              ),
              buildSpaceVertical(16.h),

              GetTextField(
                controller: emailController,
                hintName: StringsManager.email,
                icon: Icons.email,
              ),
              buildSpaceVertical(2.h),
              PasswordField(
                passController: passwordController,
                hintText: StringsManager.passHint,
                errorMsj: StringsManager.passError,
                passwordVisibility: _passwordVisibleOne,
                icon: Icons.lock,
              ),

              buildSpaceVertical(2.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/forgotPass');
                    },
                    child: textStyle1_5(StringsManager.forgotPass, TextAlign.end, ColorManager.primaryColor),
                  ),
                  buildSpaceHorizontal(6.w),

                ],
              ),

              buildSpaceVertical(3.h),
              InkWell(
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    _authController.login(emailController.text.trim(), passwordController.text.trim());
                  }
                },
                child: Obx(() {
                  return  _authController.isLoading.isTrue ?
                  Center(
                    child: Container(
                        height: 7.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s26),
                          color: ColorManager.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(AppSize.s0_5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Center(child: CupertinoActivityIndicator())),
                  )
                      : const LargeButton(
                      title:  StringsManager.login,
                      color: ColorManager.primaryColor);
                }),
              ),

              buildSpaceVertical(1.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: AssetImages.fbIcon,
                    press: () {},
                  ),
                  buildSpaceHorizontal(6.w),
                  Obx(() {
                    return _authController.isGLoading.isTrue ?
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                        height: 13.h,
                        width: 13.w,
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,

                        ),
                        child: const Center(child: CupertinoActivityIndicator()))
                        : SocialCard(
                      icon: AssetImages.googleIcon,
                      press: () {
                        _authController.signInWithGoogle(true);
                      },
                    );
                  })
                ],
              ),

              buildSpaceVertical(2.h),
              LoginNoAccountText(toggleView: toggleView),

            ],
          ),
        ),
      ),
    );
  }
}
