import 'dart:async';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/constants/values_manager.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class RegisterSuccessScreen extends StatefulWidget {
  const RegisterSuccessScreen({Key? key}) : super(key: key);

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      Get.offNamed('/authView');
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSpaceVertical(10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Image.asset(AssetImages.success, height: 50.h),
          ),
          buildSpaceVertical(10.h),
          textStyle5(StringsManager.registerSuccess, TextAlign.center,
              ColorManager.primaryColor),
        ],
      ),
    );
  }
}
