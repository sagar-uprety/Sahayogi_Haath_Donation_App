import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/transaction_const.dart';
import '../../components/transaction_components/transaction_card.dart';
import 'package:intl/intl.dart';
class DonationStream extends StatelessWidget {
    String orgName ;
    DonationStream({this.orgName});
    DateTime day;
    String donor;
    String donorImage;
    String time;
    String donee;
    double amount;

    String viewdata(){
      if(orgName == null){
        print(null);
        return null;
      }else{
        return orgName;
      }
    }
    
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: viewdata() == null ? Firestore.instance.collection('transaction').orderBy('dateTime').snapshots()
             : Firestore.instance.collection('transaction').where('donee', isEqualTo: orgName).orderBy('dateTime').snapshots(),
              builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Container(height:50,child: Text('Select Organization',style: kAdminTransactionCard,));
                  }
                  final donations = snapshot.data.documents.reversed;
                  List <TransactionCard> donationLists = [];
                  for(var donation in donations){
                     donor = donation.data['donor'];
                     donee = donation.data['donee'];
                     donorImage = donation.data['donorImage'];
                     DateTime date = donation.data['dateTime'].toDate();
                      time = DateFormat('dd MMM yyyy').format(date);
                      amount = donation.data['amount'].toDouble();
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