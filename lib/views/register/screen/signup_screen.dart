import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/constants/values_manager.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';
import '../../../widgets/large_button.dart';
import '../../../widgets/password_field.dart';
import '../../../widgets/text_field.dart';
import '../../login/components/social_card.dart';
import '../components/signup_no_account_text.dart';

class SignupScreen extends StatelessWidget {
  final Function toggleView;
  SignupScreen({Key? key, required this.toggleView}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _passwordVisibleOne = false;
  final bool _passwordVisibleTwo = false;

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
                child: textStyle7(StringsManager.registerAcc, TextAlign.center,
                    ColorManager.primaryColor),
              ),
              buildSpaceVertical(1.5.h),
              Center(
                child: textStyle2(StringsManager.signupText, TextAlign.center,
                    ColorManager.grayColor),
              ),
              buildSpaceVertical(10.h),

              GetTextField(
                controller: nameController,
                hintName: StringsManager.ename,
                icon: Icons.person,
              ),
              buildSpaceVertical(2.h),

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

              PasswordField(
                passController: confirmPasswordController,
                hintText: StringsManager.cPassHint,
                errorMsj: StringsManager.passError,
                passwordVisibility: _passwordVisibleTwo,
                icon: Icons.lock,
              ),

              buildSpaceVertical(3.h),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      _authController.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    } else {
                      errorToast(
                          StringsManager.error, StringsManager.passUnMatch);
                    }
                  }
                },
                child: Obx(() {
                  return _authController.isRLoading.isTrue
                      ? Center(
                          child: Container(
                              height: 7.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s26),
                                color: ColorManager.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.withOpacity(AppSize.s0_5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Center(
                                  child: CupertinoActivityIndicator())),
                        )
                      : const LargeButton(
                          title: StringsManager.signup,
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
                    return _authController.isGLoading.isTrue
                        ? Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p12),
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
                            child: const Center(
                                child: CupertinoActivityIndicator()))
                        : SocialCard(
                            icon: AssetImages.googleIcon,
                            press: () {
                              _authController.signInWithGoogle(false);
                            },
                          );
                  })
                ],
              ),

              // buildSpaceVertical(2.h),
              SignupNoAccountText(toggleView: toggleView),
            ],
          ),
        ),
      ),
    );
  }
}
