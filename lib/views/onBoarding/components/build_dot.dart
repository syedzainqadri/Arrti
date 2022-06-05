import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/values_manager.dart';
import 'package:flutter/material.dart';

AnimatedContainer buildDot({int? index, int? current}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: DurationConstant.d200),
    margin: const EdgeInsets.only(right: AppPadding.p6),
    height: 6,
    width: current == index ? 20 : 6,
    decoration: BoxDecoration(
      color:
          current == index ? ColorManager.primaryColor : ColorManager.grayColor,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}
