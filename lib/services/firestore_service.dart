import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahayogihaath/screens/activities_screen/acitivity_list.dart';
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
<<<<<<< HEAD

  Future<void> removeActivity(String activityId) {
    return _db.collection('activities').document(activityId).delete();
=======
  Future<void> removeActivity(String description){
    return _db.collection('activities').document(ActivitiesList.id).delete();
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
  }
}
