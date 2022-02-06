

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/strings_manager.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class FbAuthController extends GetxController{

  FirebaseAuth mAuth;
  FbAuthController({required this.mAuth});

  var statusString = "Welcome".obs;
  var isLoading = false.obs;

  String get statusResult => statusString.value;
  bool get loadingStatus => isLoading.value;

   signInWithFacebook() async {
    isLoading.value = true;
    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email','public_profile']);

    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        final userCred = await mAuth.signInWithCredential(facebookAuthCredential);
      final userData = await FacebookAuth.instance.getUserData();
        statusString.value = userData['email'];

        isLoading.value = false;
        Get.snackbar(StringsManager.success, StringsManager.loggedSuccess,
            backgroundColor: ColorManager.primaryColor,
            colorText: ColorManager.whiteColor,
            snackPosition: SnackPosition.BOTTOM);


    } else {
      isLoading.value = false;
      Get.snackbar(StringsManager.error, result.message ?? "",
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}