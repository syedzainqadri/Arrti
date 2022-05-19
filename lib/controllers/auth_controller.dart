
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/helpers/firebase_helper.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {

  var isLoading = false.obs;
  var isGLoading = false.obs;
  var isFLoading = false.obs;
  var isRLoading = false.obs;
  UserCredential? _userCredential;
  User? user;

  bool get loadingStatus => isLoading.value;
  bool get loadingGStatus => isGLoading.value;
  bool get loadingFStatus => isFLoading.value;
  bool get loadingRStatus => isRLoading.value;

  void signInWithGoogle(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isGLoading.value = true;
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        _userCredential =  await auth.signInWithCredential(credential).catchError((onErr) {
          errorToast(StringsManager.error, onErr.toString());
        });
        addAuthData(_userCredential!.user!.displayName!, _userCredential!.user!.email!, "");
        prefs.setString("userId", _userCredential!.user!.uid);
        if(isLogin){
          Get.toNamed('/signinSuccess');
        }else{
          Get.toNamed('/signupSuccess');
        }
        isGLoading.value = false;
      }else{
        errorToast(StringsManager.error, StringsManager.alreadyLogged);
      }
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
      isGLoading.value = true;
    }
  }

  void register(String name, String email, String password) async {
    try {
      isRLoading.value = true;
      _userCredential =  await auth.createUserWithEmailAndPassword(email: email, password: password);
      addAuthData(name, email, password);
      isRLoading.value = false;
      Get.toNamed('/signupSuccess');
      successToast(StringsManager.success, StringsManager.successMsj);
    } on FirebaseAuthException catch (e) {
      errorToast(StringsManager.error, e.message!);
      isRLoading.value = false;
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
      isRLoading.value = false;
    }
  }

  void login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading.value = true;
      _userCredential =  await auth.signInWithEmailAndPassword(email: email, password: password);
      prefs.setString("userId", _userCredential!.user!.uid);
      isLoading.value = false;
      Get.toNamed('/signinSuccess');
      successToast(StringsManager.success, StringsManager.successMsj);
    } on FirebaseAuthException catch (e) {
      errorToast(StringsManager.error, e.message!);
      isLoading.value = false;
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
      isLoading.value = false;
    }
  }

  void sendResetMail(String email) async{
    isFLoading.value = true;
    try{
      await auth.sendPasswordResetEmail(email: email);
      successToast(StringsManager.success, StringsManager.successEmail);
      Get.toNamed('/authView');
    }catch(e){
      errorToast(StringsManager.error, e.toString());
      isFLoading.value = false;
    }
  }


  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
    }
  }

  void googleSignOut() {
    try {
      googleSign.signOut();
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
    }
  }

  void addAuthData(String name, String email, String password) async {
    user = _userCredential!.user;
    await FirebaseFirestore.instance.collection('usersAuthData').doc(user!.uid).set({
      "id": user!.uid,
      "name": name,
      "email": email,
      "password": password,
    });
  }

}