import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahayogihaath/screens/transaction/user_transaction.dart';
import '../screens/transaction/transaction_card.dart';
import 'package:intl/intl.dart';
class DonationStream extends StatelessWidget {
    MyChoice stateChoice;
    DonationStream({this.stateChoice});
    String day;
    String donor;
    String donorImage;
    String time;
    String donee;
    double amount;
    chooseState(MyChoice data){
      String data;
      if(stateChoice == MyChoice.my){
        data = 'shreya shrestha';
      }
      else{
        data = null;
      }
      return data;
    }
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: Firestore.instance.collection('transaction').where('donor', isEqualTo : chooseState(MyChoice.my)).orderBy('time').snapshots(),
              builder: (context, snapshot){
                  final donations = snapshot.data.documents.reversed;
                  List <TransactionCard> donationLists = [];
                  for(var donation in donations){
                     donor = donation.data['donor'];
                     donee = donation.data['donee'];
                     donorImage = donation.data['donorImage'];
                     DateTime date = donation.data['time'].toDate();
                      time = DateFormat('dd MMM yyyy').format(date);
                      amount = donation.data['amount'].toDouble();
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