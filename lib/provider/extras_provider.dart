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
  String _name;
  String _description;
  File _image;
  String _bannerImage;

  //getters
  String get id => _id;
  String get description => _description;
  String get banner => _bannerImage;

  //setters
  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  changeBannerImage(File value) async{
    _image = value;
    notifyListeners();
    await saveBannerImage();
  }

  loadValues(OrganizationDetail organizationDetail) {
    _id = organizationDetail.id;
    _name = organizationDetail.name;
    _description = organizationDetail.description;
    _bannerImage = organizationDetail.bannerImage;
  }

  getCurrentUserInfo()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return _service.getData(path: FirestorePath.extras(user.uid)).then((value) {
      print(value);
      loadValues(OrganizationDetail.fromFirestore(value));
    });
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
    await ImageUploader()
        .deleteImage(path: CloudPath.org_banner, id: _id);
  }

  saveDescription(){
    _service.updateData(path: FirestorePath.extras(_id), data: {'description' : description});
  }

  saveBannerImage() async{
    await deleteImage();
    bool uploadStatus = await uploadImage(_id);
    if(uploadStatus)
      _service.updateData(path: FirestorePath.extras(_id), data: {'banner_image': _bannerImage});
  }

  saveIdName(String id,String name) {
    _service.saveData(path: FirestorePath.extras(id), data: {'id': id,'name': name});
  }

  removeInfo(String id) {
    deleteImage();
    _service.deleteData(
        path: FirestorePath.extras(id));
    notifyListeners(); //check
  }
  
}
