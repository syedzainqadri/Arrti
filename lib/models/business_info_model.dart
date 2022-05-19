

import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfoModel {
  String? userId;
  String? businessName;
  String? email;
  String? ntnNo;
  String? city;
  String? district;
  String? address;
  String? mandiName;
  String? profileImage;
  String? memberSince;
  bool?   membershipStatus;

  BusinessInfoModel({this.userId, this.businessName, this.email, this.ntnNo, this.city, this.district, this.address,
    this.mandiName, this.profileImage, this.memberSince, this.membershipStatus});

  BusinessInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    businessName = json['businessName'];
    email = json['email'];
    ntnNo = json['ntnNo'];
    city = json['city'];
    district = json['district'];
    address = json['address'];
    mandiName = json['mandi'];
    profileImage = json['image'];
    memberSince = json['memberSince'];
    membershipStatus = json['membershipStatus'];
  }

  factory BusinessInfoModel.fromDocument(DocumentSnapshot doc) {
    return BusinessInfoModel(
      userId: doc.get('id'),
      businessName: doc.get('businessName'),
      email: doc.get('email'),
      ntnNo: doc.get('ntnNo'),
      city: doc.get('city'),
      district: doc.get('district'),
      address: doc.get('address'),
      mandiName: doc.get('mandi'),
      profileImage: doc.get('image'),
      memberSince: doc.get('memberSince'),
      membershipStatus: doc.get('membershipStatus'),
    );
  }

}