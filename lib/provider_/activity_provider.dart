import 'package:flutter/cupertino.dart';
import 'package:sahayogihaath/services/firestore_service.dart';
import '../models/activitymodel.dart';

class ActivityProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  String _description;

  String get name => _name;
  String get description => _description;

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  loadValues(Activity activity) {
    _name = activity.name;
    _description = activity.description;
  }

  saveActivity() {
    var newActivity = Activity(name: name, description: description);
    firestoreService.saveActivity(newActivity);
  }
}
