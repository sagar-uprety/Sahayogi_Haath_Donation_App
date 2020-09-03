import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sahayogihaath/models/organizationmodel.dart';
import '../models/activitymodel.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveData({@required String path,@required Map<String,dynamic> data}) {
    final reference = _db.document(path);
    print('$path: $data');
    return reference.setData(data);
  }

  Stream<List<Activity>> getDatas({@required String path}) {
    return _db.collection(path).snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Activity.fromFirestore(document.data))
        .toList());
  }

   Stream<List<OrganizationDetail>> getdocsData({@required String path}) {
    return _db.collection(path).snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => OrganizationDetail.fromFirestore(document.data))
        .toList());
  }

  Future<Map<String,dynamic>> getData({@required String path}) {
    return _db.document(path).get().then((doc) => doc.data);
  }

  Future<void> deleteData({@required String path}) {
    final reference = _db.document(path);
    print('delete: $path');
    return reference.delete();
  }
}
