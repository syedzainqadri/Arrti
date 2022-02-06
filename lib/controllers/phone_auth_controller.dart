
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/strings_manager.dart';
import 'package:firebase_auth_app/views/home_screen.dart';
import 'package:get/get.dart';

class PhoneAuthController extends GetxController {
  FirebaseAuth mAuth;
  PhoneAuthController({required this.mAuth});

  var statusString = "Welcome".obs;
  var codeSent = "No".obs;
  var verificationId = "1".obs;

  String get statusResult => statusString.value;
  String get codeSentResult => codeSent.value;
  String get verificationResult => verificationId.value;

  signInWithPhoneNumber({required String phoneNo}) async {
    await mAuth.verifyPhoneNumber(
        phoneNumber: "+92" + phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
        await mAuth.signInWithCredential(credential).then((value) {
          Get.snackbar(StringsManager.success, StringsManager.loggedSuccess,
            backgroundColor: ColorManager.primaryColor,
            colorText: ColorManager.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          statusString.value = "Failed to verify your number";
          Get.snackbar(StringsManager.error, e.toString(),
              backgroundColor: ColorManager.redColor,
              colorText: ColorManager.whiteColor,
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationID, int? resendToken) {
          codeSent.value = "Yes";
          verificationId.value = verificationID;
        },
        codeAutoRetrievalTimeout: (String time) {},
        timeout: const Duration(seconds: 120)
    );
  }

  myCreadentials(String verifyID, String userInput){
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verifyID, smsCode: userInput);
    mAuth.signInWithCredential(authCredential).then((value) {

      Get.snackbar(StringsManager.success, StringsManager.loggedSuccess,
          backgroundColor: ColorManager.primaryColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);

      Get.offAll(() => const HomeScreen());

    }).catchError((e){
      Get.snackbar(
          StringsManager.error, e.toString(),
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM
      );
    });
  }
}