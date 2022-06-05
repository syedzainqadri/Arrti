import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/strings_manager.dart';
import '../utils/helpers/helper.dart';

class PersonalProfileCompletionController extends GetxController {
  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;
  var imageUrl = "".obs;
  String? userId;

  uploadData(
      String firstName,
      String lastName,
      String email,
      String phoneNo,
      String cnicNo,
      String province,
      String city,
      String address,
      File image) async {
    isLoading.value = true;
    try {
      Reference ref = FirebaseStorage.instance.ref().child(image.path);
      await ref.putFile(image);
      imageUrl.value = await ref.getDownloadURL();
      addPersonalData(
          firstName, lastName, email, phoneNo, cnicNo, province, city, address);
      isLoading.value = false;
      Get.toNamed('/businessPC');
    } catch (e) {
      errorToast(StringsManager.error, e.toString());
      isLoading.value = false;
    }
  }

  void addPersonalData(
      String firstName,
      String lastName,
      String email,
      String phoneNo,
      String cnicNo,
      String province,
      String city,
      String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    String userName = firstName + lastName;
    List<String> splitList = userName.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
      }
    }
    await FirebaseFirestore.instance
        .collection('usersPersonalData')
        .doc(userId)
        .set({
      "id": userId,
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName.toLowerCase(),
      "email": email,
      "phoneNo": phoneNo,
      "cnicNo": cnicNo,
      "province": province,
      "city": city,
      "address": address,
      "image": imageUrl.value,
      "searchIndex": indexList,
    });
  }
}
