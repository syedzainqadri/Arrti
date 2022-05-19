import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/font_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class LargeButton extends StatelessWidget {
  final String title;
  final Color color;
  const LargeButton({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 7.h,
        width: 60.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s26),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(AppSize.s0_5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: AppSize.s18,
              color: ColorManager.whiteColor,
              fontWeight: FontWeightManager.medium,
            ),
          ),
        ),
      ),
    );
  }
}
