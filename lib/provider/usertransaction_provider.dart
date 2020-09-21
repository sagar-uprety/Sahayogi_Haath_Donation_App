import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/usertransactionmodel.dart';

import '../services/firestore_service.dart';
import '../services/firestore_path.dart';

  String currentUser;
class UserTransactionProvider with ChangeNotifier{
  final _service = FirestoreService();
  Timestamp time;
  String donorImage;
  String _transactionId;
  String donor;
  String donee;
  String amount;
  String userName;
  
  loadValues(UserTransactionModel transaction) {
    time = transaction.time;
    donorImage = transaction.donorImage;
    donor = transaction.donor;
    donee = transaction.donee;
    _transactionId = transaction.transactionId;
    amount = transaction.amount;
  }
  

  Stream<List<UserTransactionModel>> getTransactions(){
    return _service.getConditionData(
      path: FirestorePath.transactions(), 
      key: 'donor',
      value: currentUser,
    ).map((snapshot) => snapshot
    .documents
    .map((doc) => UserTransactionModel.fromFirestore(doc.data))
    .toList());
  }
  saveTransaction(String amount, String donorId, String donor, String donee, String donorImage, Timestamp time, String id) {
      var newTransaction = UserTransactionModel(
        donorId: donorId,
        time: time,
        donorImage: donorImage,
        donor: donor, 
        donee: donee,
        amount: amount, 
        transactionId: id);
      _service.saveData(path: FirestorePath.transaction(id), data: newTransaction.toMap());
      print(amount);
    notifyListeners();
  }
  
}
