import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/image_upload.dart';
import '../services/firestore_path.dart';
import '../services/firestore_service.dart';
import '../models/extras_model.dart';

class ExtrasProvider with ChangeNotifier {
  final _service = FirestoreService();

  String _id;
  String _description;
  File _image;
  String _bannerImage;

  double _amount;
  int _count;

  //getters
  String get id => _id;
  String get description => _description;
  String get banner => _bannerImage;
  double get amount => _amount;
  int get count => _count;
  //setters
  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  changeBannerImage(File value) async {
    _image = value;
    notifyListeners();
    await saveBannerImage();
  }

  changeAmount(double value) {
    _amount = _amount + value;
    _count = _count + 1;
    notifyListeners();
  }

  setNull() {
    _id = null;
    _amount = null;
    _count = null;
    _description = null;
    _bannerImage = null;
  }

  loadValues({DonorDetail donor, OrganizationDetail organization}) {
    if (donor != null) {
      _id = donor.id;
      _amount = donor.donatedAmount;
      _count = donor.countDonation;
    } else if (organization != null) {
      _id = organization.id;
      _description = organization.description;
      _bannerImage = organization.bannerImage;
      _amount = organization.receivedAmount;
      _count = organization.countDonation;
    }
  }

  getCurrentUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return _service.getData(path: FirestorePath.extras(user.uid)).then((value) {
      print(value);
      if (value['donated_amount'] != null) {
        loadValues(donor: DonorDetail.fromFirestore(value));
      } else {
        loadValues(organization: OrganizationDetail.fromFirestore(value));
      }
    });
  }

  Stream<OrganizationDetail> getUserExtrabyId(String id) {
    return _service
        .getData(path: FirestorePath.extras(id))
        .then((value) => OrganizationDetail.fromFirestore(value))
        .asStream();
  }

  Future<bool> uploadImage(id) async {
    bool isUploaded = false;
    await ImageUploader()
        .uploadImage(image: _image, path: CloudPath.org_banner, id: id)
        .then((String value) {
      _bannerImage = value;
      notifyListeners();
      _image = null;
      isUploaded = true;
    });
    return isUploaded;
  }

  Future<void> deleteImage() async {
    await ImageUploader().deleteImage(path: CloudPath.org_banner, id: _id);
  }

  saveDescription() {
    _service.updateData(
        path: FirestorePath.extras(_id), data: {'description': description});
  }

  saveBannerImage() async {
    await deleteImage();
    bool uploadStatus = await uploadImage(_id);
    if (uploadStatus)
      _service.updateData(
          path: FirestorePath.extras(_id),
          data: {'banner_image': _bannerImage});
  }

  saveAmountandCount() {
    _service.updateData(
        path: FirestorePath.extras(_id),
        data: {'donated_amount': amount, 'count_donation': count});
  }

  saveAmountandCountOrg(
    String id, {
    @required double updatedAmount,
    @required int updatedCount,
  }) {
    _service.updateData(path: FirestorePath.extras(id), data: {
      'received_amount': updatedAmount,
      'count_donation': updatedCount
    });
  }

  saveIdName(String id, [bool isDonor = false]) {
    if (isDonor)
      _service.saveData(path: FirestorePath.extras(id), data: {
        'id': id,
        'donated_amount': 0,
        'count_donation': 0
      });
    else
      _service.saveData(path: FirestorePath.extras(id), data: {
        'id': id,
        'received_amount': 0,
        'count_donation': 0
      });
  }

  removeInfo(String id) {
    deleteImage();
    _service.deleteData(path: FirestorePath.extras(id));
    notifyListeners(); //check
  }
}
