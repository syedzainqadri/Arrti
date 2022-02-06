import 'package:firebase_auth_app/constants/firebase_constants.dart';
import 'package:firebase_auth_app/constants/helper.dart';
import 'package:firebase_auth_app/controllers/email_auth_controller.dart';
import 'package:firebase_auth_app/controllers/fb_auth_controller.dart';
import 'package:firebase_auth_app/controllers/phone_auth_controller.dart';
import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/font_manager.dart';
import 'package:firebase_auth_app/utils/strings_manager.dart';
import 'package:firebase_auth_app/utils/values_manager.dart';
import 'package:firebase_auth_app/views/widgets/large_button.dart';
import 'package:firebase_auth_app/views/widgets/password_field.dart';
import 'package:firebase_auth_app/views/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EmailAuthScreen extends StatelessWidget {
  EmailAuthScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _passwordVisibleOne = false;


  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _phoneFormKey = GlobalKey<FormState>();
  String verificationID = "";

  final PhoneAuthController _phoneAuthController = Get.put(PhoneAuthController(mAuth: auth));
  final FbAuthController _fbAuthController = Get.put(FbAuthController(mAuth: auth));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildSpaceVertical(AppSize.s80),
              buildTitle(),
              buildSpaceVertical(AppSize.s80),
              GetTextField(
                controller: _emailController,
                hintName: StringsManager.email,
              ),
              buildSpaceVertical(AppSize.s20),
              PasswordField(
                passController: _passwordController,
                hintText: StringsManager.passHint,
                errorMsj: StringsManager.passError,
                passwordVisibility: _passwordVisibleOne,
              ),
              buildSpaceVertical(AppSize.s30),
              buildButtons(),
              buildSpaceVertical(AppSize.s20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.redColor,
                ),
                onPressed: () {
                  EmailAuthController.authInstance.signInWithGoogle();
                },
                child: const Text("Sign In with Google"),
              ),

              buildSpaceVertical(AppSize.s20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.grayColor,
                ),
                onPressed: () => _newPhoneAuthBottomSheet(context),
                child: const Text("Continue with Phone"),
              ),

              buildSpaceVertical(AppSize.s20),
              Obx((){
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.blueColor,
                  ),
                  onPressed: () async => await _fbAuthController.signInWithFacebook(),
                  child: _fbAuthController.isLoading.isTrue ? const CupertinoActivityIndicator() : const Text("Sign in with Facebook"),
                );
              }),


            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              EmailAuthController.authInstance.register(
                _emailController.text.trim(),
                _passwordController.text.trim(),
              );
            },
            child: const LargeButton(
                title: StringsManager.registerBtn,
                color: ColorManager.primaryColor),
          ),
          InkWell(
            onTap: () {
              EmailAuthController.authInstance.login(
                _emailController.text.trim(),
                _passwordController.text.trim(),
              );
            },
            child: const LargeButton(
                title: StringsManager.loginBtn,
                color: ColorManager.primaryColor),
          ),


        ],
      ),
    );
  }

  Text buildTitle() {
    return const Text(StringsManager.welcome,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: FontSize.s18,
          color: ColorManager.primaryColor,
          letterSpacing: 1,
          fontWeight: FontWeightManager.bold,
        ));
  }

  void _newPhoneAuthBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Form(
            key: _phoneFormKey,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetTextField(
                    controller: phoneController,
                    hintName: StringsManager.phone,
                    maxLength: 10,
                    inputType: TextInputType.phone,
                  ),

                  buildSpaceVertical(AppSize.s10),

                  Obx(() {
                    return _phoneAuthController.codeSentResult == "Yes" ?
                        Column(
                          children: [
                            buildSpaceVertical(AppSize.s10),
                            GetTextField(
                              controller: otpController,
                              hintName: StringsManager.otp,
                              maxLength: 6,
                              inputType: TextInputType.number,
                            ),
                            MaterialButton(
                              color: ColorManager.primaryColor,
                              onPressed: () async{
                               await _phoneAuthController.myCreadentials(
                                    _phoneAuthController.verificationResult,
                                    otpController.text.trim()
                                );
                              },
                              child: const Text("Verify",
                                style: TextStyle(
                                  color: ColorManager.whiteColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                        : const SizedBox.shrink();
                  }),

                  buildSpaceVertical(AppSize.s10),

                  MaterialButton(
                    color: ColorManager.primaryColor,
                    onPressed: () async{
                      await _phoneAuthController.signInWithPhoneNumber(phoneNo: phoneController.text.trim());
                    },
                    child: const Text("Login",
                      style: TextStyle(
                        color: ColorManager.whiteColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}
