import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../FireStoredata.dart';
import '../../components/transaction_components/transaction_card.dart';
import 'package:intl/intl.dart';

class OrgDonationStream extends StatelessWidget {
    DateTime startDate;
    DateTime endDate;
    OrgDonationStream({this.startDate,this.endDate});
    DateTime day;
    String donor;
    String donorImage;
    String time;
    String donee;
    double amount;
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: Firestore.instance.collection(collection).where(dateTime, isGreaterThan: startDate).where(dateTime,isLessThan: endDate).orderBy(dateTime).snapshots(),
              builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
                  final donations = snapshot.data.documents.reversed;
                  List <TransactionCard> donationLists = [];
                  for(var donation in donations){
                     donor = donation.data[user];
                     donee = donation.data[organization];
                     donorImage = donation.data[userImage];
                     DateTime date = donation.data[dateTime].toDate();
                      time = DateFormat('dd MMM yyyy').format(date);
                      amount = donation.data[donationAmount].toDouble();
                      DateTime day = donation.data['dateTime'].toDate();     
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