import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/values_manager.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passController;
  late bool passwordVisibility;
  final String hintText, errorMsj;

  PasswordField({Key? key, required this.passController, required this.passwordVisibility,
    required this.hintText, required this.errorMsj}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: TextFormField(
        controller: widget.passController,
        obscureText: !widget.passwordVisibility,
        enabled: true,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorMsj;
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
          hintText: widget.hintText,
          fillColor: ColorManager.whiteColor,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              widget.passwordVisibility ? Icons.visibility : Icons.visibility_off,
              color: ColorManager.primaryColor,
            ),
            onPressed: () {
              setState(() {
                widget.passwordVisibility = !widget.passwordVisibility;
              });
            },
          ),
        ),
      ),
    );
  }
}