import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/usertransactionmodel.dart';

import '../services/firestore_path.dart';
import '../services/transaction.dart';

class UserTransactionProvider with ChangeNotifier{
  final firestoreService = TransactionFirestoreService();
  String _transactionId;
  String _donor;
  String _donee;
  //double _amount;
  var uuid = Uuid();


  //getters
  String get donor => _donor;
  String get donee => _donee;
  //double get amount => _amount;

  //setters
  changeDonor(String value) {
    _donor = value;
    notifyListeners();
  }

  changeDonee(String value) {
    _donee = value;
    notifyListeners();
  }

  // changeAmount(String value) {
  //   _amount = double.parse(value);
  //   notifyListeners();
  //}

  loadValues(UserTransactionModel transaction) {
    _donor = transaction.donor;
    _donee = transaction.donee;
    _transactionId = transaction.transactionId;
    //_amount = transaction.amount;
  }
  saveTransaction() {
    print(_transactionId);
    if (_transactionId == null) {
      String id = uuid.v4();
      var newTransaction = UserTransactionModel(
        donor: _donor, 
        donee: _donee,
        //amount: _amount, 
        transactionId: id);
      firestoreService.saveTransaction(path: FirestorePath.transaction(id), data: newTransaction.toMap());
    } else {
      //Update
      var updatedTransaction = UserTransactionModel(
        donor: _donor, 
        //amount: _amount,
        donee: _donee,
        transactionId: _transactionId);
      firestoreService.saveTransaction(path: FirestorePath.transaction(_transactionId), data: updatedTransaction.toMap());
    }
    notifyListeners();
  }

  removeTransaction(String transactionId){
    firestoreService.deleteTransaction(path: FirestorePath.transaction(transactionId));
    notifyListeners();
  }
  
}
