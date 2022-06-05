import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfoModel {
  String? userId;
  String? businessName;
  String? email;
  String? ntnNo;
  String? phoneNo;
  String? phoneNo01;
  String? phoneNo02;
  String? city;
  String? district;
  String? address;
  String? province;
  String? mandiName;
  String? profileImage;
  String? memberSince;
  bool? membershipStatus;
  bool? isPresidence;

  BusinessInfoModel(
      {this.userId,
      this.businessName,
      this.email,
      this.ntnNo,
      this.phoneNo,
      this.phoneNo01,
      this.phoneNo02,
      this.city,
      this.district,
      this.address,
      this.province,
      this.mandiName,
      this.profileImage,
      this.memberSince,
      this.membershipStatus,
      this.isPresidence});

  BusinessInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    businessName = json['businessName'];
    email = json['email'];
    ntnNo = json['ntnNo'];
    phoneNo = json['phoneNo'];
    phoneNo01 = json['phoneNo01'];
    phoneNo02 = json['phoneNo02'];
    city = json['city'];
    district = json['district'];
    address = json['address'];
    province = json['province'];
    mandiName = json['mandi'];
    profileImage = json['image'];
    memberSince = json['memberSince'];
    membershipStatus = json['membershipStatus'];
    isPresidence = json['isPresidence'];
  }

  factory BusinessInfoModel.fromDocument(DocumentSnapshot doc) {
    return BusinessInfoModel(
      userId: doc.get('id'),
      businessName: doc.get('businessName'),
      email: doc.get('email'),
      ntnNo: doc.get('ntnNo'),
      phoneNo: doc.get('phoneNo'),
      phoneNo01: doc.get('phoneNo01'),
      phoneNo02: doc.get('phoneNo02'),
      city: doc.get('city'),
      district: doc.get('district'),
      address: doc.get('address'),
      province: doc.get('province'),
      mandiName: doc.get('mandi'),
      profileImage: doc.get('image'),
      memberSince: doc.get('memberSince'),
      membershipStatus: doc.get('membershipStatus'),
      isPresidence: doc.get('isPresidence'),
    );
  }
}
