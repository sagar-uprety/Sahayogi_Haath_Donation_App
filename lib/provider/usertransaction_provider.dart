import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/usertransactionmodel.dart';

import '../services/firestore_service.dart';
import '../services/firestore_path.dart';

String currentUser;

class UserTransactionProvider with ChangeNotifier {
  final _service = FirestoreService();

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

  Stream<List<UserTransactionModel>> getTransactionsbyOrg(String id) {
    return _service
        .getConditionData(
          path: FirestorePath.transactions(),
          key: 'doneeId',
          value: id,
        )
        .map((snapshot) => snapshot.documents
            .map((doc) => UserTransactionModel.fromFirestore(doc.data))
            .toList());
  }

  saveTransaction(UserTransactionModel transaction,{String id}) {
    _service.saveData(
        path: FirestorePath.transaction(id), data: transaction.toMap());
    notifyListeners();
  }
}
