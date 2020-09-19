import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/usertransactionmodel.dart';
import '../../provider/usertransaction_provider.dart';



import '../../components/transaction_components/usertransaction_card.dart';
class UserTransactionMain extends StatelessWidget {
  String userid;
  DateTime selectedDate;
  DateTime endDate;
  DateTime day;
    String donor;
    String donorImage;
    Timestamp time;
    String donee;
    String amount;
  UserTransactionMain({this.userid, this.selectedDate, this.endDate});
  @override
  Widget build(BuildContext context) {
      return StreamBuilder <QuerySnapshot>(
      stream: (selectedDate == null && endDate==null) ? Firestore.instance.collection('transaction').where('donorId', isEqualTo: userid).orderBy('time').snapshots() : Firestore.instance.collection('transaction').where('donorId', isEqualTo: userid).where('time', isGreaterThan: selectedDate).where('time',isLessThan: endDate).orderBy('time').snapshots(),
              builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
                  List <Widget> donationLists = [];
                  final donations = snapshot.data.documents.reversed;
                  for(var donation in donations){
                     donor = donation.data['donor'];
                     donee = donation.data['donee'];
                     donorImage = donation.data['donorImage'];
                    time = donation.data['time'];
                      amount = donation.data['amount'];    
                    donationLists.add(UserTransactionCard(day: day, donor: donor, donorImage: donorImage, datetime: time, donee: donee,amount: amount,));
                  }
                  return  Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: donationLists,
  );
  }
   
      );
}
}