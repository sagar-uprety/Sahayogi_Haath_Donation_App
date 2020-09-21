import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../provider/activity_provider.dart';
import '../provider/extras_provider.dart';

import '../models/usermodel.dart';

import '../services/firestore_path.dart';
import '../services/image_upload.dart';
import '../services/firestore_service.dart';

class UserProvider extends ChangeNotifier {
  final _service = FirestoreService();

  SaveState _state = SaveState.Uninitialized;

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

  File _profile;

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

  SaveState get saveState => _state;

  //setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePhone(String value) {
    _phone = value;
    notifyListeners();
  }

  changeAddress(String value) {
    _address = value;
    notifyListeners();
  }

  changeProfileImage(File value) async{
    _profile = value;
    notifyListeners();
    await saveProfileImage();
  }

  changeEstablishedDate(String value) {
    _establishedDate = value;
    notifyListeners();
  }

  changeType(String value) {
    _type = value;
    notifyListeners();
  }

  getUserData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return _service.getData(path: FirestorePath.user(user.uid)).then((value) {
      print(value);
      if (value['isDonor'] == true || value['isAdmin'] == true) {
        loadDonorData(DonorModel.fromFirestore(value));
      } else {
        loadOrganizationData(OrganizationModel.fromFirestore(value));
      }
    });
  }

  Stream<List<OrganizationModel>> getOrganizations(){
    return _service.getConditionData(path: FirestorePath.users(), key: 'isOrganization', value: true)
        .map((snapshot) => snapshot
        .documents
        .map((doc) =>OrganizationModel.fromFirestore(doc.data))
        .toList());
  }

  loadDonorData(DonorModel donor) {
    _id = donor.id;
    _name = donor.name;
    _email = donor.email;
    _phone = donor.phone;
    _address = donor.address;
    _profileImage = donor.profileImage;
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

  Future<bool> uploadImage(id) async {
    bool isUploaded = false;
    await ImageUploader()
        .uploadImage(image: _profile, path: CloudPath.profile, id: id)
        .then((String value) {
      _profileImage = value;
      notifyListeners();
      _profile = null;
      isUploaded = true;
    });
    return isUploaded;
  }

  Future<void> deleteImage() async {
    await ImageUploader().deleteImage(path: CloudPath.profile, id: _id);
  }

  saveName(){
    _service.updateData(path: FirestorePath.user(id), data: {'name' : name});
    ExtrasProvider().saveIdName(id,name);
  }

  saveAddress(){
    _service.updateData(path: FirestorePath.user(id), data: {'address' : address});
  }

  savePhone(){
    _service.updateData(path: FirestorePath.user(id), data: {'phone' : phone});
  }

  saveEstablishmentDate(){
    _service.updateData(path: FirestorePath.user(id), data: {'established_date': establishedDate});
  }

  saveType(){
    _service.updateData(path: FirestorePath.user(id), data: {'type': type});
  }

  saveProfileImage() async{
    await deleteImage();
    bool uploadStatus = await uploadImage(_id);
    if(uploadStatus)
      _service.updateData(path: FirestorePath.user(id), data: {'profile_image': profileImage});
  }

  Future<void> registerDonor(DonorModel donor) async {
    await _service.saveData(
      path: FirestorePath.user(donor.id),
      data: donor.toMap(),
    );
  }

  Future<void> registerOrganization(OrganizationModel organization) async {
    await _service.saveData(
      path: FirestorePath.user(organization.id),
      data: organization.toMap(),
    );
  }
}
