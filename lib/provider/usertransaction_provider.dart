import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/usertransactionmodel.dart';

import '../services/firestore_service.dart';
import '../services/firestore_path.dart';

class UserTransactionProvider with ChangeNotifier{
  final _service = FirestoreService();
  String _transactionId;
  // String _donor;
  // String _donee;
  String _amount;
  var uuid = Uuid();

  loadValues(UserTransactionModel transaction) {
    // _donor = transaction.donor;
    // _donee = transaction.donee;
    _transactionId = transaction.transactionId;
    _amount = transaction.amount;
  }

  Stream<List<UserTransactionModel>> getTransactions(){
    return _service.getDatas(path: FirestorePath.transactions()).map((snapshot) => snapshot
    .documents
    .map((doc) => UserTransactionModel.fromFirestore(doc.data))
    .toList());
  }

  saveTransaction(String amount,) {
    print(_transactionId);
    if (_transactionId == null) {
      String id = uuid.v4();
      var newTransaction = UserTransactionModel(
        // donor: _donor, 
        // donee: _donee,
        amount: amount, 
        transactionId: id);
      _service.saveData(path: FirestorePath.transaction(id), data: newTransaction.toMap());
      print(amount);
    } else {
      //Update
      var updatedTransaction = UserTransactionModel(
        // donor: _donor, 
        amount: _amount,
        // donee: _donee,
        transactionId: _transactionId);
      _service.saveData(path: FirestorePath.transaction(_transactionId), data: updatedTransaction.toMap());
    }
    notifyListeners();
  }

  removeTransaction(String transactionId){
    _service.deleteData(path: FirestorePath.transaction(transactionId));
    notifyListeners();
  }
  
}
