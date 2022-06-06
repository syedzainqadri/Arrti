import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInfoModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? cnicNo;
  String? city;
  String?country;
  String? address;
  String? province;
  String? profileImage;

  PersonalInfoModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNo,
      this.cnicNo,
      this.city,
        this.country,
      this.address,
      this.province,
      this.profileImage});

  factory PersonalInfoModel.fromDocument(DocumentSnapshot doc) {
    return PersonalInfoModel(
      userId: doc.get('id'),
      firstName: doc.get('firstName'),
      lastName: doc.get('lastName'),
      email: doc.get('email'),
      phoneNo: doc.get('phoneNo'),
      cnicNo: doc.get('cnicNo'),
      city: doc.get('city'),
        country:doc.get('country'),
      address: doc.get('address'),
      province: doc.get('province'),
      profileImage: doc.get('image'),
    );
  }

  PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    cnicNo = json['cnicNo'];
    city = json['city'];
    country=json['city'];
    address = json['address'];
    province = json['province'];
    profileImage = json['image'];
  }
}
