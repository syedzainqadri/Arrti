import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Future searchPersonalData(String queryString) async {
    // print(queryString);
    return FirebaseFirestore.instance
        .collection('usersPersonalData')
        .where('searchIndex', arrayContains: queryString)
        // .where('firstName', arrayContains: queryString.toLowerCase()+ "\uf8ff")
        .get();
  }

  Future searchBusinessData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('usersBusinessData')
        .where('searchIndex', arrayContains: queryString)
        // .where('businessName', arrayContains: queryString.toLowerCase()+ "\uf8ff")
        .get();
  }
}
