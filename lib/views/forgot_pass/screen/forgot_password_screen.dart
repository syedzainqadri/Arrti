import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/constants/values_manager.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';
import '../../../widgets/large_button.dart';
import '../../../widgets/text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSpaceVertical(9.h),

            // buildSpaceVertical(4.h),

            Center(
              child: textStyle7(StringsManager.forgotPass, TextAlign.center,
                  ColorManager.primaryColor),
            ),
            buildSpaceVertical(1.5.h),
            Center(
              child: textStyle2(StringsManager.forgotPassText, TextAlign.center,
                  ColorManager.grayColor),
            ),
            buildSpaceVertical(30.h),

            GetTextField(
              controller: emailController,
              hintName: StringsManager.email,
              icon: Icons.email,
            ),
            buildSpaceVertical(4.h),

            InkWell(
              onTap: () {
                if (validateEmail(emailController.text.trim())) {
                  _authController.sendResetMail(emailController.text.trim());
                } else {
                  errorToast(StringsManager.error, StringsManager.wrongEmail);
                }
              },
              child: Obx(() {
                return _authController.isFLoading.isTrue
                    ? Center(
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
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Center(
                                child: CupertinoActivityIndicator())),
                      )
                    : const LargeButton(
                        title: StringsManager.continued,
                        color: ColorManager.primaryColor);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
