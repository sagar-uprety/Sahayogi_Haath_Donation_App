import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveData({@required String path,@required Map<String,dynamic> data}) {
    final reference = _db.document(path);
    print('$path: $data');
    return reference.setData(data);
  }
  
  Stream<QuerySnapshot> getDatas({@required String path}){
    return _db.collection(path).snapshots().map((snapshot) => snapshot);
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
