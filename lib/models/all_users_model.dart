import 'package:cloud_firestore/cloud_firestore.dart';

class AlluserModel {
  String? name;
  String? iD;
  String? email;

  AlluserModel({this.name, this.iD, this.email});
  factory AlluserModel.fromjson(DocumentSnapshot snapshot) {
    return AlluserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      iD: snapshot["id"],
    );
  }
}

List<AlluserModel> userslist = [];
