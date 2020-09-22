import 'package:cloud_firestore/cloud_firestore.dart';

class UserTransactionModel {
  final String transactionId;
  final String donorId;
  final String donor;
  final String donorImage;
  final String doneeId;
  final String donee;
  final String doneeImage;
  final double amount;
  final Timestamp time;

  UserTransactionModel({
    this.transactionId,
    this.donorId,
    this.donor,
    this.donorImage,
    this.doneeId,
    this.donee,
    this.doneeImage,
    this.amount,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'donorId': donorId,
      'donor': donor,
      'donorImage': donorImage,
      'doneeId': doneeId,
      'donee': donee,
      'doneeImage': doneeImage,
      'amount': amount,
      'time': time,
    };
  }

  UserTransactionModel.fromFirestore(Map<String, dynamic> firestore)
      : transactionId = firestore['transactionId'],
        donorId = firestore['donorId'],
        donor = firestore['donor'],
        donorImage = firestore['donorImage'],
        doneeId = firestore['doneeId'],
        donee = firestore['donee'],
        doneeImage = firestore['doneeImage'],
        amount = firestore['amount'],
        time = firestore['time'];
}
