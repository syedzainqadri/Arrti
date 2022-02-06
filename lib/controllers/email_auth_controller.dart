import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/constants/firebase_constants.dart';
import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:firebase_auth_app/utils/strings_manager.dart';
import 'package:firebase_auth_app/views/email_auth_screen.dart';
import 'package:firebase_auth_app/views/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EmailAuthController extends GetxController {
  static EmailAuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);


    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);


  }

  _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => EmailAuthScreen());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount == null) {
      Get.offAll(() =>  EmailAuthScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).catchError((onErr) {
          Get.snackbar(StringsManager.error, onErr.toString(),
              backgroundColor: ColorManager.redColor,
              colorText: ColorManager.whiteColor,
              snackPosition: SnackPosition.BOTTOM);
        });
      }
    } catch (e) {
      Get.snackbar(StringsManager.error, e.toString(),
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(StringsManager.error, e.message!,
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar(StringsManager.error, e.toString(),
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(StringsManager.error, e.message!,
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar(StringsManager.error, e.toString(),
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      Get.snackbar(
          StringsManager.error, e.toString(),
          backgroundColor: ColorManager.redColor,
          colorText: ColorManager.whiteColor,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

}