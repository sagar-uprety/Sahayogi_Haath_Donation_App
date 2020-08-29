import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahayogihaath/image_upload.dart';
import 'package:uuid/uuid.dart';

import '../services/firestore_service.dart';
import '../models/activitymodel.dart';

enum SaveState { Uninitialized, Saving, Saved }

class ActivityProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  SaveState _state = SaveState.Uninitialized;

  String _title;
  String _description;
  String _activityID;
  File _image;
  String _imageUrl;
  var uuid = Uuid();

  //getters
  String get title => _title;
  String get description => _description;
  String get image => _imageUrl;

  SaveState get saveState => _state;

  //setters
  changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  changeImage(File value) {
    _image = value;
    notifyListeners();
  }

  loadValues(Activity activity) {
    _title = activity.title;
    _description = activity.description;
    _activityID = activity.activityID;
    _imageUrl = activity.image;
  }

  Future<bool> uploadImage(uid) async {
    bool isUploaded = false;
    await ImageUploader()
        .uploadImage(image: _image, path: CloudPath.activities, id: uid)
        .then((String value) {
      _imageUrl = value;
      isUploaded = true;
    });
    return isUploaded;
  }

  Future<void> deleteImage() async {
    await ImageUploader()
        .deleteImage(path: CloudPath.activities, id: _activityID);
  }

  saveActivity() async {
    _state = SaveState.Saving;
    if (_activityID == null) {
      String id = uuid.v4();
      bool uploadStatus = await uploadImage(id);

      print(_title + ' ' + _description + ' ' + _imageUrl + ' ' + id);
      if (uploadStatus) {
        //create new activity
        var newActivity = Activity(
            title: title,
            description: description,
            image: image,
            activityID: id);
        await firestoreService.saveActivity(newActivity);
      } else {
        print('Error Uploading the file.');
      }
    } else {
      //update
      await deleteImage();
      bool uploadStatus = await uploadImage(_activityID);
      if (uploadStatus) {
        var updatedActivity = Activity(
            title: title,
            description: description,
            image: image,
            activityID: _activityID);
        firestoreService.saveActivity(updatedActivity);
      }
    }
    _state = SaveState.Saved;
    notifyListeners(); //check
  }

  removeActivity(String activityID) {
    deleteImage();
    firestoreService.removeActivity(activityID);
    notifyListeners(); //checl
  }
}
