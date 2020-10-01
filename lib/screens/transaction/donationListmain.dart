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
            return Text('Loading');
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
  final String orgName;
  AdminTransactionMain({this.orgName});

  String viewAlldata(String name) {
    String name1 = name;
    if (name1 == null) {
      return name1;
    } else {
      return name1;
    }
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: (orgName != null)
            ? Firestore.instance
                .collection('transaction')
                .orderBy('time')
                .snapshots()
            : Firestore.instance
                .collection('transaction')
                .where('donee', isEqualTo: viewAlldata(orgName))
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
            if (orgName == null) {
              donationLists.add(TransactionCard(
                  UserTransactionModel.fromFirestore(donation.data)));
            } else if (donation.data['donee'] == orgName) {
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
  final String orgName;
  OrgTransaction({this.startDate, this.endDate, this.orgName});

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: (startDate == null && endDate == null)
            ? Firestore.instance
                .collection('transaction')
                .where('donee', isEqualTo: orgName)
                .orderBy('time')
                .snapshots()
            : Firestore.instance
                .collection('transaction')
                .where('donorId', isEqualTo: orgName)
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
