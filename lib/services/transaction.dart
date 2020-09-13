 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';

 import '../models/usertransactionmodel.dart';
 class TransactionFirestoreService {
     Firestore _db = Firestore.instance;
    Future<void> saveTransaction({@required String path,@required Map<String,dynamic> data}) {
        final reference = _db.document(path);
        print('$path: $data');
        return reference.setData(data);
      }

 
  Stream<List<UserTransactionModel>> getTransaction({@required String path}){
    return _db.collection('transaction').snapshots().map((snapshot) => snapshot.
    documents.map((document) => UserTransactionModel.fromFirestore(document.data)).toList());
  }

   Future<void> deleteTransaction({@required String path}) {
    final reference = _db.document(path);
    print('delete: $path');
    return reference.delete();
  }
 }