import 'dart:io';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessProfileCompletionController extends GetxController {
  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;
  var imageUrl = "".obs;
  String? userId;

  uploadData(
      String businessName,
      String address,
      String email,
      String phoneNo,
      String ntnNo,
      String city,
      String province,
      String district,
      String mandi,
      String memberSince,
      File image) async {
    isLoading.value = true;
    try {
      Reference ref = FirebaseStorage.instance.ref().child(image.path);
      await ref.putFile(image);
      imageUrl.value = await ref.getDownloadURL();
      addBusinessData(businessName, address, email, phoneNo, ntnNo, city,
          province, district, mandi, memberSince);
      isLoading.value = false;
      Get.toNamed('/waitingView');
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
      isLoading.value = false;
    }
  }

  void addBusinessData(
      String businessName,
      String address,
      String email,
      String phoneNo,
      String ntnNo,
      String city,
      String province,
      String district,
      String mandi,
      String memberSince) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    List<String> splitList = businessName.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }
    await FirebaseFirestore.instance
        .collection('usersBusinessData')
        .doc(userId)
        .set({
      "id": userId,
      "businessName": businessName.toLowerCase(),
      "address": address,
      "email": email,
      "phoneNo": phoneNo,
      "ntnNo": ntnNo,
      "city": city,
      "province": province,
      "district": district,
      "mandi": mandi,
      "memberSince": memberSince,
      "membershipStatus": false,
      "image": imageUrl.value,
      "searchIndex": indexList,
    });
  }
}
