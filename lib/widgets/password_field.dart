import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passController;
  late bool passwordVisibility;
  final String hintText, errorMsj;
  final IconData icon;

  PasswordField({Key? key, required this.passController, required this.passwordVisibility,
    required this.hintText, required this.errorMsj, required this.icon}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: AppSize.s14),
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
          prefixIcon: Icon(widget.icon, color: ColorManager.primaryColor),
        ),
      ),
    );
  }
}