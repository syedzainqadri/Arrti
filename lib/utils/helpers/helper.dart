import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

successToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.primaryColor,
      textColor: ColorManager.whiteColor,
      fontSize: 16.0
  );
}

errorToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorManager.redColor,
      textColor: ColorManager.whiteColor,
      fontSize: 16.0
  );
}

validateEmail(String email) {
  final emailReg = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}


SizedBox buildSpaceVertical(height) => SizedBox(height: height);
SizedBox buildSpaceHorizontal(width) => SizedBox(width: width);