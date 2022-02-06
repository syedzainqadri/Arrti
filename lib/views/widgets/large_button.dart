import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/font_manager.dart';
import 'package:firebase_auth_app/utils/values_manager.dart';
import 'package:flutter/material.dart';


class LargeButton extends StatelessWidget {
  final String title;
  final Color color;
  const LargeButton({Key? key, required this.title, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppSize.s50,
        width: AppSize.s140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
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
            style: const TextStyle(
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
