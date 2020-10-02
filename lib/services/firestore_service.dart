import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/extras_model.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveData({@required String path,@required Map<String,dynamic> data}) {
    final reference = _db.document(path);
    print('$path: $data');
    return reference.setData(data);
  }
  
  Stream<QuerySnapshot> getDatas({@required String path,@required String orderBy}){
    return _db.collection(path).orderBy(orderBy,descending: true).snapshots().map((snapshot) => snapshot);
  }

  Future<void> updateData({@required String path, @required Map<String, dynamic> data}){
    final reference = _db.document(path);
    return reference.updateData(data);
  }

  Stream<QuerySnapshot> getUserTransaction({@required String path, String username, DateTime startDate, DateTime endDate}){
    print(startDate);
      return _db.collection(path).where('donorId', isEqualTo: username).where('time', isGreaterThan: startDate).orderBy('time', descending: true).snapshots().map((snapshot) => snapshot);
  }
  Stream<QuerySnapshot> getConditionData({@required String path,@required String key,@required value, @required order, desc = false}){
    return _db.collection(path).where(key, isEqualTo: value).orderBy(order,descending: desc).snapshots().map((snapshot) => snapshot);
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
