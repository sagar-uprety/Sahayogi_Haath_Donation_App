import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahayogihaath/FireStoredata.dart';
import 'user_transaction.dart';
import '../../components/transaction_components/usertransaction_card.dart';
import 'package:intl/intl.dart';
class UserDonationStream extends StatelessWidget {
    MyChoice stateChoice;
    String userName;
    UserDonationStream({this.stateChoice, this.userName});
    DateTime day;
    String donor;
    String donorImage;
    String time;
    String donee;
    double amount;

    //String userName = 'shreya shrestha' ;
    chooseState(MyChoice data){
      String data1;
      if(stateChoice == MyChoice.my){
        data1 = userName;
      }
      else{
        data1 = null;
      }
      return data1;
    }
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: Firestore.instance.collection(collection).where(user, isEqualTo : chooseState(MyChoice.my)).orderBy('dateTime').snapshots(),
              builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
                  final donations = snapshot.data.documents.reversed;
                  List <UserTransactionCard> donationLists = [];
                  for(var donation in donations){
                     donor = donation.data[user];
                     donee = donation.data[organization];
                     donorImage = donation.data[userImage];
                     DateTime date = donation.data[dateTime].toDate();
                      time = DateFormat('dd MMM yyyy').format(date);
                      amount = donation.data[donationAmount].toDouble();
                      DateTime day = donation.data[dateTime].toDate();     
                    donationLists.add(UserTransactionCard(day: day, donor: donor, donorImage: donorImage, time: time, donee: donee,amount: amount,));
                  }
                  
                  return  Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: donationLists,
  );
              }
    );
  }
}