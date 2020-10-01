import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/image_upload.dart';
import '../services/firestore_path.dart';
import '../services/firestore_service.dart';
import '../models/activitymodel.dart';
enum SaveState { Uninitialized, Saving, Saved }

class ActivityProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
    final _service = FirestoreService();

  SaveState _state = SaveState.Uninitialized;

  String _title;
  String _description;
  String _activityID;
  File _image;
  String _imageUrl;
  String _authorid;

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
    // _activityID = activity.activityID;
    _imageUrl = activity.image;
    // _authorid = activity.authorid;
  }

  Stream<List<Activity>> getActivities() {
    return firestoreService.getDatas(path: FirestorePath.activities()).map(
        (snapshot) => snapshot.documents
            .map((doc) => Activity.fromFirestore(doc.data))
            .toList());
  }

  Stream<List<Activity>> getActivitiesbyOrg(String id) {
    return _service
        .getConditionData(
          path: FirestorePath.activities(),
          key: 'authorid',
          value: id,
          order: 'time',
          desc :true,
        )
        .map((snapshot) => snapshot.documents
            .map((doc) => Activity.fromFirestore(doc.data))
            .toList());
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

  Future<void> deleteImage(id) async {
    await ImageUploader().deleteImage(path: CloudPath.activities, id: id);
  }

  updateActivity(String id) async {
    _state = SaveState.Saving;

    await deleteImage(id);
    bool uploadStatus = await uploadImage(id);
    if (uploadStatus) {
      firestoreService.updateData(
          path: FirestorePath.activity(id),
          data: {'title': title, 'image': image, 'description': description});
    }
    _state = SaveState.Saved;
    notifyListeners();
  }

  saveActivity(String userid,String name) async {
    _state = SaveState.Saving;
    String id = uuid.v4();
    bool uploadStatus = await uploadImage(id);

    if (uploadStatus) {
      //create new activity
      var newActivity = Activity(
        title: title,
        description: description,
        image: image,
        activityID: id,
        authorid: userid,
        authorName: name,
        time: Timestamp.now()
      );
      await firestoreService.saveData(
          path: FirestorePath.activity(id), data: newActivity.toMap());
    } else {
      print('Error Uploading the file.');
    }
    _state = SaveState.Saved;
    notifyListeners(); //check
  }

  removeActivity(String activityID) {
    deleteImage(activityID);
    firestoreService.deleteData(path: FirestorePath.activity(activityID));
    notifyListeners(); //checl
  }
}
