import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../image_upload.dart';
import '../services/firestore_path.dart';
import '../services/firestore_service.dart';
import '../models/organizationmodel.dart';

enum SaveState { Uninitialized, Saving, Saved }

class OrganizationProvider with ChangeNotifier {

  final firestoreService = FirestoreService();

  SaveState _state = SaveState.Uninitialized;

  String _title;
  String _description;
  String _organizationID;
  String _searchKey;
  File _image;
  String _imageUrl;
  var uuid = Uuid();

 
  //getters
  String get title => _title;
  String get description => _description;
    String get searchKey => _searchKey;
  String get image => _imageUrl;

  SaveState get saveState => _state;

  //setters
  changeTitle(String value) {
    _title = value;
    notifyListeners(
      
    );
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

   changeSearchKey(String value) {
    _searchKey = value;
    notifyListeners();
  }

  changeImage(File value) {
    _image = value;
    notifyListeners();
  }

  loadValues(OrganizationDetail organizationDetail) {
    _description = organizationDetail.description;
    _organizationID = organizationDetail.organizationID;
    _imageUrl = organizationDetail.bannerImage;
  }

  Future<bool> uploadImage(uid) async {
    bool isUploaded = false;
    await ImageUploader()
        .uploadImage(image: _image, path: CloudPath.organizations, id: uid)
        .then((String value) {
      _imageUrl = value;
      isUploaded = true;
    });
    return isUploaded;
  }

  Future<void> deleteImage() async {
    await ImageUploader()
        .deleteImage(path: CloudPath.organizations, id: _organizationID);
  }

  saveOrganizationInfo() async {
    _state = SaveState.Saving;
    if (_organizationID == null) {
      String id = uuid.v4();
      bool uploadStatus = await uploadImage(id);

      if (uploadStatus) {
        //create new activity
        var newOrganization = OrganizationDetail(
            description: description,
            bannerImage: image,
            organizationID: id);
        await firestoreService.saveData(
            path: FirestorePath.organization(id),
            data: newOrganization.toMap());
      } else {
        print('Error Uploading the file.');
      }
    } else {
      //update
      await deleteImage();
      bool uploadStatus = await uploadImage(_organizationID);
      if (uploadStatus) {
        var updatedOrganization = OrganizationDetail(
            description: description,
            bannerImage: image,
            organizationID: _organizationID);
        firestoreService.saveData(
            path: FirestorePath.organization(_organizationID),
            data: updatedOrganization.toMap());
      }
    }
    _state = SaveState.Saved;
    notifyListeners(); //check
  }

  removeOrgInfo(String organizationID) {
    deleteImage();
    firestoreService.deleteData(
        path: FirestorePath.organization(organizationID));
    notifyListeners(); //check
  }
}
