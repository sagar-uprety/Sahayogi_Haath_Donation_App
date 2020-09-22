import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/usertransactionmodel.dart';

import '../services/firestore_service.dart';
import '../services/firestore_path.dart';

String currentUser;

class UserTransactionProvider with ChangeNotifier {
  final _service = FirestoreService();
  Timestamp time;
  String donorImage;
  String _transactionId;
  String donor;
  String donee;
  String amount;
  String userName;

  Stream<List<UserTransactionModel>> getTransactions() {
    return _service
        .getConditionData(
          path: FirestorePath.transactions(),
          key: 'donor',
          value: currentUser,
        )
        .map((snapshot) => snapshot.documents
            .map((doc) => UserTransactionModel.fromFirestore(doc.data))
            .toList());
  }

  saveTransaction(UserTransactionModel transaction,{String id}) {
    _service.saveData(
        path: FirestorePath.transaction(id), data: transaction.toMap());
    print(transaction.amount.toString() + 'to '+ transaction.donee + 'from' + transaction.donor);
    notifyListeners();
  }
}
