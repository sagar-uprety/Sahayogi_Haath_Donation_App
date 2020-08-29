import 'package:flutter/cupertino.dart';

enum UserType {donor, organization}

class DonorModel{
  DonorModel({@required this.id,@required this.name,@required this.email,@required this.address,@required this.phone,@required this.profileImage,@required this.userType});

  String id;
  String name;
  String email;
  String phone;
  String address;
  String profileImage;
  String userType;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profile_image': profileImage,
      'user_type': userType,
    };
  }

  DonorModel.fromFirestore(Map<String,dynamic> model)
      : id = model['id'],
        name = model['name'],
        email = model['email'],
        phone = model['phone'],
        address = model['address'],
        profileImage = model['profile_image'],
        userType = model['user_type'];
}

class OrganizationModel{
  OrganizationModel({@required this.id,@required this.name,@required this.email,@required this.address,@required this.phone,@required this.establishedDate,@required this.profileImage,@required this.type,@required this.userType,@required this.documentImage});

  String id;
  String email;
  String name;
  String phone;
  String address;
  String establishedDate;
  String userType;
  String type;
  String profileImage;
  String documentImage;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'established_date': establishedDate,
      'type': type,
      'profile_image': profileImage,
      'document_image': documentImage,
      'user_type': userType,
    };
  }

  OrganizationModel.fromFirestore(Map<String, dynamic> model)
      : id = model['id'],
        name = model['name'],
        email = model['email'],
        phone = model['phone'],
        address = model['address'],
        establishedDate = model['established_date'],
        type = model['type'],
        profileImage = model['profile_image'],
        documentImage = model['document_image'],
        userType = model['user_type'];
}