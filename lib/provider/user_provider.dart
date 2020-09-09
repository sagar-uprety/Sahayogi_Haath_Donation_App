import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../image_upload.dart';
import '../provider/activity_provider.dart';
import '../models/usermodel.dart';
import '../services/firestore_path.dart';
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

  changeProfileImage(File value) {
    _profile = value;
    notifyListeners();
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

  setNull(){
    _id =null;
    _name = null;
    _email = null;
    _address = null;
    _phone = null;
    _profileImage = null;
    _type = null;
    _establishedDate = null;
    _documentImage = null;
    _isOrganization = false;
    _isAdmin = false;
    _isDonor = false;
    // notifyListeners();
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
      _profile = null;
      isUploaded = true;
    });
    return isUploaded;
  }

  Future<void> deleteImage() async {
    await ImageUploader().deleteImage(path: CloudPath.profile, id: _id);
  }

  updateProfile() async {
    _state = SaveState.Saving;
    notifyListeners();

    await deleteImage();
    bool uploadStatus = await uploadImage(_id);

    if (uploadStatus) {
      if (_isDonor || _isAdmin) {
        var updatedUser = DonorModel(
          id: id,
          name: name,
          email: email,
          address: address,
          phone: phone,
          profileImage: profileImage,
          isDonor: isDonor,
          isAdmin: isAdmin,
        );

        await _service.saveData(
            path: FirestorePath.user(id), data: updatedUser.toMap());
      } else if (_isOrganization) {
        var updatedUser = OrganizationModel(
          id: id,
          name: name,
          email: email,
          address: address,
          phone: phone,
          establishedDate: establishedDate,
          profileImage: profileImage,
          type: type,
          documentImage: documentImage,
          isOrganization: isOrganization,
        );

        await _service.saveData(path: FirestorePath.user(id), data: updatedUser.toMap());
      }
    } else{
      print('File upload failed.');
    }
    _state= SaveState.Saved;
    notifyListeners();
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
