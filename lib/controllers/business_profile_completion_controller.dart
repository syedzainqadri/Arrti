import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants/strings_manager.dart';
import '../utils/helpers/helper.dart';

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
    String phoneNo01,
    String phoneNo02,
    String ntnNo,
    String city,
    String province,
    String district,
    String mandi,
    String memberSince,
    File image,
    bool? isPresident,
  ) async {
    isLoading.value = true;
    try {
      Reference ref = FirebaseStorage.instance.ref().child(image.path);
      await ref.putFile(image);
      imageUrl.value = await ref.getDownloadURL();
      addBusinessData(
        businessName,
        address,
        email,
        phoneNo,
        phoneNo01,
        phoneNo02,
        ntnNo,
        city,
        province,
        district,
        mandi,
        memberSince,
        isPresident,
      );
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
    String phoneNo01,
    String phoneNo02,
    String ntnNo,
    String city,
    String province,
    String district,
    String mandi,
    String memberSince,
    bool? isPresident,
  ) async {
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
      "phoneNo01": phoneNo01,
      "phoneNo02": phoneNo02,
      "ntnNo": ntnNo,
      "city": city,
      "province": province,
      "country": district,
      "mandi": mandi,
      "memberSince": memberSince,
      "isPresidence": isPresident,
      "membershipStatus": false,
      "image": imageUrl.value,
      "searchIndex": indexList,
    });
  }
}
