import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/Users_info_model.dart';
import '../models/business_info_model.dart';
import '../models/personal_info_model.dart';
import '../models/user_business_info_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  UserCredential? userCredential;
  String? id;
  bool get loadingStatus => isLoading.value;

  Future<PersonalInfoModel?> getPersonalData() async {
    isLoading.value = true;
    id = FirebaseAuth.instance.currentUser!.uid;
    var val = await FirebaseFirestore.instance
        .collection("usersPersonalData")
        .doc(id)
        .get();
    var documents = val.data();
    if (documents != null) {
      try {
        PersonalInfoModel personalData =
            PersonalInfoModel.fromJson(Map<String, dynamic>.from(documents));
        isLoading.value = false;
        return personalData;
      } catch (e) {
        isLoading.value = false;
        // errorToast(StringsManager.error, e.toString());
        return null;
      }
    } else {
      isLoading.value = false;
      // errorToast(StringsManager.error, StringsManager.noData);
      return null;
    }
  }

  Future<BusinessInfoModel?> getBusinessData() async {
    isLoading.value = true;
    id = FirebaseAuth.instance.currentUser!.uid;
    var val = await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .doc(id)
        .get();
    var documents = val.data();
    if (documents != null) {
      try {
        BusinessInfoModel businessData =
            BusinessInfoModel.fromJson(Map<String, dynamic>.from(documents));
        isLoading.value = false;
        return businessData;
      } catch (e) {
        isLoading.value = false;
        // errorToast(StringsManager.error, e.toString());
        return null;
      }
    } else {
      isLoading.value = false;
      // errorToast(StringsManager.error, StringsManager.noData);
      return null;
    }
  }
  //---------------------------------------------------------

  Future<UsersInfoModel?> userPersonalData(String userid) async {
    isLoading.value = true;
    // id = FirebaseAuth.instance.currentUser!.uid;
    var val = await FirebaseFirestore.instance
        .collection("usersPersonalData")
        .doc(userid)
        .get();
    var documents = val.data();
    if (documents != null) {
      try {
        UsersInfoModel personalData =
            UsersInfoModel.fromJson(Map<String, dynamic>.from(documents));
        isLoading.value = false;
        return personalData;
      } catch (e) {
        isLoading.value = false;
        // errorToast(StringsManager.error, e.toString());
        return null;
      }
    } else {
      isLoading.value = false;
      // errorToast(StringsManager.error, StringsManager.noData);
      return null;
    }
  }

  //---------------------------------------
  Future<UserBusinessInfoModel?> getUsersBusinessData(userId) async {
    isLoading.value = true;
    // id = FirebaseAuth.instance.currentUser!.uid;
    var val = await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .doc(userId)
        .get();
    var documents = val.data();
    if (documents != null) {
      try {
        UserBusinessInfoModel userbusinessData = UserBusinessInfoModel.fromJson(
            Map<String, dynamic>.from(documents));
        isLoading.value = false;
        return userbusinessData;
      } catch (e) {
        isLoading.value = false;
        // errorToast(StringsManager.error, e.toString());
        return null;
      }
    } else {
      isLoading.value = false;
      // errorToast(StringsManager.error, StringsManager.noData);
      return null;
    }
  }
}
