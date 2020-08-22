import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/transaction/transaction_card.dart';
class DonationStream extends StatelessWidget {
    String day;
    String donor;
    String donorImage;
    String time;
    String donee;
    double amount;
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: Firestore.instance.collection('transaction').orderBy('time').snapshots(),
              builder: (context, snapshot){
                  final donations = snapshot.data.documents.reversed;
                  List <TransactionCard> donationLists = [];
                  for(var donation in donations){
                     donor = donation.data['donor'];
                     donee = donation.data['donee'];
                     donorImage = donation.data['donorImage'];
                      //time = donation.data['time'].toDate();
                      time = '13/04/2020';
                      amount = donation.data['amount'];
                      //day = donation.data['day'];
                      day = 'Today';                    
                    donationLists.add(TransactionCard(day: day, donor: donor, donorImage: donorImage, time: time, donee: donee,amount: amount,));
                  }
                  
                  return  Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: donationLists,
  );
              }
    );
  }
}