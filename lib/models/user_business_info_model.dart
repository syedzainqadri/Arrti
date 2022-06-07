import 'package:cloud_firestore/cloud_firestore.dart';

class UserBusinessInfoModel {
  String? userId;
  String? businessName;
  String? email;
  String? ntnNo;
  String? phoneNo;
  String? city;
  String? district;
  String? address;
  String? province;
  String? mandiName;
  String? profileImage;
  String? memberSince;
  bool? membershipStatus;
  bool? isPresidence;

  UserBusinessInfoModel(
      {this.userId,
      this.businessName,
      this.email,
      this.ntnNo,
      this.phoneNo,
      this.city,
      this.district,
      this.address,
      this.province,
      this.mandiName,
      this.profileImage,
      this.memberSince,
      this.membershipStatus,
      this.isPresidence});

  UserBusinessInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    businessName = json['businessName'];
    email = json['email'];
    ntnNo = json['ntnNo'];
    phoneNo = json['phoneNo'];
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

  factory UserBusinessInfoModel.fromDocument(DocumentSnapshot doc) {
    return UserBusinessInfoModel(
      userId: doc.get('id'),
      businessName: doc.get('businessName'),
      email: doc.get('email'),
      ntnNo: doc.get('ntnNo'),
      phoneNo: doc.get('phoneNo'),
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
