import 'package:flutter/cupertino.dart';
import 'package:sahayogihaath/services/firestore_service.dart';
import '../models/activitymodel.dart';

class ActivityProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _activityTitle;
  String _description;

  String get name => _activityTitle;
  String get description => _description;

  changeName(String value) {
    _activityTitle = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  loadValues(Activity activity) {
    _activityTitle = activity.activityTitle;
    _description = activity.description;
  }

  saveActivity() {
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

  }
}
