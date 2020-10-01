import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/usertransactionmodel.dart';

import '../../components/transaction_components/transaction_card.dart';
import '../../components/transaction_components/usertransaction_card.dart';

class UserTransactionMain extends StatelessWidget {
  final String userid;
  final DateTime selectedDate;
  final DateTime endDate;
  UserTransactionMain({this.userid, this.selectedDate, this.endDate});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: (selectedDate == null && endDate == null)
            ? Firestore.instance
                .collection('transaction')
                .where('donorId', isEqualTo: userid)
                .orderBy('time')
                .snapshots()
            : Firestore.instance
                .collection('transaction')
                .where('donorId', isEqualTo: userid)
                .where('time', isGreaterThan: selectedDate)
                .where('time', isLessThan: endDate)
                .orderBy('time')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Widget> donationLists = [];

          final donations = snapshot.data.documents.reversed;
          for (var donation in donations) {
            DateTime date = donation.data['time'].toDate();

            if (selectedDate == null && endDate == null) {
              donationLists.add(UserTransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            } else if (date.isAfter(selectedDate) && date.isBefore(endDate)) {
              donationLists.add(UserTransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: donationLists,
          );
        });
  }
}

class AdminTransactionMain extends StatelessWidget {
  final String id;
  AdminTransactionMain({this.id});

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: (id != null)
            ? Firestore.instance
                .collection('transaction')
                .orderBy('time')
                .snapshots()
            : Firestore.instance
                .collection('transaction')
                .where('doneeId', isEqualTo: id)
                .orderBy('time')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return Text('Loading');
          }
          final donations = snapshot.data.documents.reversed;
          List<Widget> donationLists = [];
          for (var donation in donations) {
            if (id == null) {
              donationLists.add(TransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            } else if (donation.data['doneeId'] == id) {
              donationLists.add(TransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: donationLists,
          );
        });
  }
}

class OrgTransaction extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String id;
  OrgTransaction({this.startDate, this.endDate, this.id});

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: (startDate == null && endDate == null)
            ? Firestore.instance
                .collection('transaction')
                .where('doneeId', isEqualTo: id)
                .orderBy('time')
                .snapshots()
            : Firestore.instance
                .collection('transaction')
                .where('doneeId', isEqualTo: id)
                .where('time', isGreaterThan: startDate)
                .where('time', isLessThan: endDate)
                .orderBy('time')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return Text('Loading');
          }
          List<Widget> donationLists = [];

          final donations = snapshot.data.documents.reversed;
          for (var donation in donations) {
            DateTime date = donation.data['time'].toDate();
            if (startDate == null && endDate == null) {
              donationLists.add(TransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            } else if (date.isAfter(startDate) && date.isBefore(endDate)) {
              donationLists.add(TransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            }
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: donationLists,
          );
        });
  }
}
