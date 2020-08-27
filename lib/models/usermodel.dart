
enum UserType {donor, organization}

class DonorModel{
  DonorModel({this.name,this.email,this.address,this.phone,this.profileImage,this.userType,this.isAdmin=false});

  String name;
  String email;
  String phone;
  String address;
  String profileImage;
  String userType;
  bool isAdmin;
}

class OrganizationModel{
  OrganizationModel({this.name,this.email,this.address,this.phone,this.establishedDate,this.profileImage,this.type,this.userType,this.documentImage});

  String email;
  String name;
  String phone;
  String address;
  String establishedDate;
  String userType;
  String type;
  String profileImage;
  String documentImage;
}