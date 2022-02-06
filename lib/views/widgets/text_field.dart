import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/values_manager.dart';
import 'package:flutter/material.dart';

class GetTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintName;
  final bool isObscureText;
  final TextInputType inputType;
  final bool isEnable;
  final int inputLines;
  final int maxLength;

  const GetTextField({Key? key, this.controller, this.hintName, this.isObscureText = false,
    this.inputType = TextInputType.text, this.isEnable = true, this.inputLines = 1, this.maxLength = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        maxLines: inputLines,
        maxLength: maxLength,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          hintText: hintName,
          fillColor: ColorManager.whiteColor,
          filled: true,
        ),
      ),
    );
  }
}