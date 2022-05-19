import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/font_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupNoAccountText extends StatelessWidget {
  final Function toggleView;
  const SignupNoAccountText({Key? key, required this.toggleView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: StringsManager.haveAcc,
          style: GoogleFonts.openSans(
            fontSize: FontSize.s12,
            color: ColorManager.grayColor,
            fontWeight: FontWeightManager.regular,
          ),
          children: <TextSpan>[
            TextSpan(
                text: StringsManager.login,
                style: GoogleFonts.openSans(
                  fontSize: FontSize.s14,
                  color: ColorManager.primaryColor,
                  fontWeight: FontWeightManager.regular,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    toggleView();
                  }),
          ],
        ),
      ),
    );
  }
}
