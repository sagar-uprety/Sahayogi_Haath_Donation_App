import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../services/firestore_service.dart';
import '../models/activitymodel.dart';

class ActivityProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
<<<<<<< HEAD
  String _title;
=======
  String _activityTitle;
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
  String _description;
  String _activityID;
  var uuid = Uuid();

<<<<<<< HEAD
  //getters
  String get title => _title;
  String get description => _description;

  //setters
  changeTitle(String value) {
    _title = value;
=======
  String get name => _activityTitle;
  String get description => _description;

  changeName(String value) {
    _activityTitle = value;
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  loadValues(Activity activity) {
<<<<<<< HEAD
    _title = activity.title;
=======
    _activityTitle = activity.activityTitle;
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
    _description = activity.description;
    _activityID = activity.activityID;
  }

  saveActivity() {
<<<<<<< HEAD
    if (_activityID == null) {
      //create new activity
      var newActivity = Activity(
          title: title, description: description, activityID: uuid.v4());
      firestoreService.saveActivity(newActivity);
    } else {
      //update
      var updatedActivity = Activity(
          title: title, description: description, activityID: _activityID);
      firestoreService.saveActivity(updatedActivity);
    }
    // notifyListeners();
  }

  removeActivity(String activityID) {
    firestoreService.removeActivity(activityID);
    // notifyListeners();
=======
    if(_description == null){
  var newActivity = Activity(
      activityTitle: _activityTitle,
      description: _description,
    );
    firestoreService.saveActivity(newActivity);
    }else{
      var updatedActivity = 
      Activity(
          activityTitle: _activityTitle,
      description: _description,
      );
        firestoreService.saveActivity(updatedActivity);

    }
  
  }
  removeActivity(String description){
            firestoreService.removeActivity (description);

>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
  }
}
