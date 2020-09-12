import 'package:flutter/cupertino.dart';

enum UserType {donor, organization}

class DonorModel{
  DonorModel({@required this.id,@required this.name,@required this.email,@required this.address,@required this.phone,@required this.profileImage, this.isDonor,this.isAdmin});

  String id;
  String name;
  String email;
  String phone;
  String address;
  String profileImage;
  bool isDonor;
  bool isAdmin;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profile_image': profileImage,
      'isDonor': isDonor,
      'isAdmin': isAdmin,
    };
  }

  DonorModel.fromFirestore(Map<String,dynamic> model)
      : id = model['id'],
        name = model['name'],
        email = model['email'],
        phone = model['phone'],
        address = model['address'],
        profileImage = model['profile_image'],
        isDonor = model['isDonor'],
        isAdmin = model['isAdmin'];
}

class OrganizationModel{
  OrganizationModel({@required this.id,@required this.name,@required this.email,@required this.address,@required this.phone,@required this.establishedDate,@required this.profileImage,@required this.type,@required this.documentImage,this.description,this.isOrganization});

  String id;
  String email;
  String name;
  String phone;
  String address;
  String establishedDate;
  bool isOrganization;
  String type;
  String profileImage;
  String documentImage;
  String description;

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
      'isOrganization': isOrganization,
      'description': description
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
        isOrganization = model['isOrganization'],
        description = model['description'];
}