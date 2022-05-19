

import 'package:apni_mandi/models/business_info_model.dart';
import 'package:apni_mandi/models/personal_info_model.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  var isLoading = false.obs;
  UserCredential? userCredential;
  String? id;
  bool get loadingStatus => isLoading.value;


  Future<PersonalInfoModel?> getPersonalData() async {

    isLoading.value = true;
    id = FirebaseAuth.instance.currentUser!.uid;
    var val = await FirebaseFirestore.instance.collection("usersPersonalData").doc(id).get();
    var documents = val.data();
    if (documents!.isNotEmpty) {
      try {
         PersonalInfoModel personalData = PersonalInfoModel.fromJson(Map<String, dynamic>.from(documents));
         isLoading.value = false;
         return personalData;
      } catch (e) {
        isLoading.value = false;
        errorToast(StringsManager.error, e.toString());
        return null;
      }
    }
    isLoading.value = false;
    errorToast(StringsManager.error, StringsManager.noData);
    return null;
  }

  Future<BusinessInfoModel?> getBusinessData() async {
    isLoading.value = true;
    id = FirebaseAuth.instance.currentUser!.uid;
    var val = await FirebaseFirestore.instance.collection("usersBusinessData").doc(id).get();
    var documents = val.data();
    if (documents!.isNotEmpty) {
      try {
        BusinessInfoModel businessData = BusinessInfoModel.fromJson(Map<String, dynamic>.from(documents));
        isLoading.value = false;
        return businessData;
      } catch (e) {
        isLoading.value = false;
        errorToast(StringsManager.error, e.toString());
        return null;
      }
    }
    isLoading.value = false;
    errorToast(StringsManager.error, StringsManager.noData);
    return null;
  }
}