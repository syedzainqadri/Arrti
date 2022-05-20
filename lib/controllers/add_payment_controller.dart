

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddPaymentController extends GetxController {

  var isLoading = false.obs;
  bool get loadingStatus => isLoading.value;
  String? userId;


  void addPaymentData(String phoneNo, String transID) async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    await FirebaseFirestore.instance.collection('paymentData').doc(userId).set({
      "id": userId,
      "phoneNo": phoneNo,
      "transID": transID,
      "status": true,
      "approved": "",
    });
    isLoading.value = false;
    Get.offAllNamed('/waitingView');
  }

}