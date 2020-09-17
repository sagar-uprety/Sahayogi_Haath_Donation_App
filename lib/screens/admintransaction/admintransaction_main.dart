import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/transaction_const.dart';
import '../../components/transaction_components/transaction_card.dart';
import '../../FireStoredata.dart';
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

    String viewAlldata(String name){
      String name1 = name;
      if(name1 == null){
        return name1;
      }
      else{
        return name1;
      }
    }

   
    
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: Firestore.instance.collection(collection).where(organization, isEqualTo: viewAlldata(orgName)).orderBy(dateTime).snapshots(),
              builder: (context, snapshot){
                print(orgName);
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Container(height:50,child: Text('Loading',style: kAdminTransactionCard,));
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
                      DateTime day = donation.data[dateTime].toDate();     
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