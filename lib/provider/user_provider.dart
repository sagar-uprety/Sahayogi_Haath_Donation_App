
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/usermodel.dart';
import '../services/firestore_path.dart';
import '../services/firestore_service.dart';

class UserProvider extends ChangeNotifier {
  final _service = FirestoreService();

  String _id;
  String _name;
  String _email;
  String _phone;
  String _address;
  String _profileImage;
  String _establishedDate;
  String _type;
  String _documentImage;
  bool _isDonor = false;
  bool _isOrganization = false;
  bool _isAdmin = false;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  String get profileImage => _profileImage;
  String get establishedDate => _establishedDate;
  String get type => _type;
  String get documentImage => _documentImage;
  bool get isDonor => _isDonor;
  bool get isOrganization => _isOrganization;
  bool get isAdmin => _isAdmin;

  getUserData() async{
    FirebaseUser user= await FirebaseAuth.instance.currentUser();
    return _service.getData(path: FirestorePath.user(user.uid)).then((value) {
      print(value);
      if(value['isDonor'] == true || value['isAdmin'] == true){
        loadDonorData(DonorModel.fromFirestore(value));
      } else{
        loadOrganizationData(OrganizationModel.fromFirestore(value));
      }
    });
  }

  loadDonorData(DonorModel donor){
    _id = donor.id;
    _name = donor.name;
    _email = donor.email;
    _phone = donor.phone;
    _address = donor.address;
    _profileImage= donor.profileImage;
    _isDonor = donor.isDonor;
    _isAdmin = donor.isAdmin;
    notifyListeners();
  }

  loadOrganizationData(OrganizationModel organization) {
    _id = organization.id;
    _name = organization.name;
    _email = organization.email;
    _phone = organization.phone;
    _address = organization.address;
    _profileImage = organization.profileImage;
    _establishedDate = organization.establishedDate;
    _type = organization.type;
    _documentImage = organization.documentImage;
    _isOrganization = organization.isOrganization;
    notifyListeners();
  }

  Future<void> registerDonor(DonorModel donor) async{
    await _service.saveData(
      path: FirestorePath.user(donor.id), 
      data: donor.toMap(),
    );
  }

  Future<void> registerOrganization(OrganizationModel organization) async{
    await _service.saveData(
      path: FirestorePath.user(organization.id), 
      data: organization.toMap(),
    );
  }
}