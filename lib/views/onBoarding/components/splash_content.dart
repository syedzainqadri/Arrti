import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key, this.text, this.image}) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildSpaceVertical(10.h),
        textStyle5(StringsManager.appName, TextAlign.center,
            ColorManager.primaryColor),
        buildSpaceVertical(1.h),
        textStyle2(text!, TextAlign.center, ColorManager.grayColor),
        buildSpaceVertical(10.h),
        Image.asset(image!, height: 35.h, width: 70.w),
      ],
    );
  }
}
