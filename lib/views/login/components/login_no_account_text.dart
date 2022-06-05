import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/font_manager.dart';
import '../../../utils/constants/strings_manager.dart';

class LoginNoAccountText extends StatelessWidget {
  final Function toggleView;
  const LoginNoAccountText({Key? key, required this.toggleView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: StringsManager.noAccount,
          style: GoogleFonts.openSans(
            fontSize: FontSize.s12,
            color: ColorManager.grayColor,
            fontWeight: FontWeightManager.regular,
          ),
          children: <TextSpan>[
            TextSpan(
                text: StringsManager.signup,
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
