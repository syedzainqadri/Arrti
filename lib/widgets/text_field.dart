import 'package:flutter/material.dart';

import '../utils/constants/color_manager.dart';
import '../utils/constants/values_manager.dart';

class GetTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintName;
  final bool isObscureText;
  final TextInputType inputType;
  final bool isEnable;
  final int inputLines;
  final int inputLength;
  final IconData icon;

  const GetTextField(
      {Key? key,
      this.controller,
      this.hintName,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true,
      this.inputLines = 1,
      required this.icon,
      this.inputLength = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: TextFormField(
          controller: controller,
          obscureText: isObscureText,
          enabled: isEnable,
          keyboardType: inputType,
          maxLines: inputLines,
          maxLength: inputLength,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintName';
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.redColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.redColor),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            prefixIcon: Icon(icon, color: ColorManager.primaryColor),
            hintText: hintName,
            hintStyle: const TextStyle(fontSize: AppSize.s14),
            fillColor: ColorManager.whiteColor,
            filled: true,
          ),
        ),
      ),
    );
  }
}

class GetTextField1 extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintName;
  final bool isObscureText;
  final TextInputType inputType;
  final bool isEnable;
  final int inputLines;
  final int inputLength;
  final IconData icon;

  const GetTextField1(
      {Key? key,
      this.controller,
      this.hintName,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true,
      this.inputLines = 1,
      required this.icon,
      this.inputLength = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: TextFormField(
          controller: controller,
          obscureText: isObscureText,
          enabled: isEnable,
          keyboardType: inputType,
          maxLines: inputLines,
          maxLength: inputLength,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter $hintName';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.redColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.redColor),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
              borderSide: BorderSide(color: ColorManager.primaryColor),
            ),
            prefixIcon: Icon(icon, color: ColorManager.primaryColor),
            hintText: hintName,
            hintStyle: const TextStyle(fontSize: AppSize.s14),
            fillColor: ColorManager.whiteColor,
            filled: true,
          ),
        ),
      ),
    );
  }
}
