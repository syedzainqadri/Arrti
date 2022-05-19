import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key? key, this.icon, this.press}) : super(key: key);

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        height: 12.h,
        width: 12.w,
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
        child: Image.asset(icon!, fit: BoxFit.contain),
      ),
    );
  }
}
