import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activitymodel.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveActivity(Activity activity) {
    return _db
        .collection('activities')
        .document(activity.activityID)
        .setData(activity.toMap());
  }

  Stream<List<Activity>> getActivities() {
    return _db.collection('activities').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Activity.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeActivity(String activityId) {
    return _db.collection('activities').document(activityId).delete();
  }


}
