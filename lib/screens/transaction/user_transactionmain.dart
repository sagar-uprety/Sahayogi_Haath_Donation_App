import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/transaction_components/transaction_card.dart';




import '../../components/transaction_components/usertransaction_card.dart';


class UserTransactionMain extends StatelessWidget {
  String userid;
  DateTime selectedDate;
  DateTime endDate;
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
                    DateTime date = donation.data['time'].toDate();
                      amount = donation.data['amount'];  
                       if(selectedDate==null && endDate==null){
                        donationLists.add(UserTransactionCard(donor: donor, donorImage: donorImage, datetime: time, donee: donee, amount: amount,));
                      } 
                      else if(date.isAfter(selectedDate) &&  date.isBefore(endDate)){
                        donationLists.add(UserTransactionCard(donor: donor, donorImage: donorImage, datetime: time, donee: donee, amount: amount,));
                      }  
                  }
                  return  Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: donationLists,
  );
  }
   
      );
}
}

class AdminTransactionMain extends StatelessWidget {
    String orgName ;  
    String donor;
    String donorImage;
    Timestamp time;
    String donee;
    String amount;
    AdminTransactionMain({this.orgName});

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
      stream: (orgName != null) ?  Firestore.instance.collection('transaction').orderBy('time').snapshots() : Firestore.instance.collection('transaction').where('donee', isEqualTo: viewAlldata(orgName)).orderBy('time').snapshots(),
              builder: (context, snapshot){
                 if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
                  
                 
                    final donations = snapshot.data.documents.reversed;
                   List <Widget> donationLists = [];
                  for(var donation in donations){
                       donor = donation.data['donor'];
                     donee = donation.data['donee'];
                     donorImage = donation.data['donorImage'];
                    time = donation.data['time'];
                      amount = donation.data['amount'];   
                       if(orgName==null){
                        donationLists.add(TransactionCard(donor: donor, donorImage: donorImage, datetime: time, donee: donee, amount: amount,));
                      } 
                      else if(donee == orgName){
                        donationLists.add(TransactionCard(donor: donor, donorImage: donorImage, datetime: time, donee: donee, amount: amount,));
                      }
                  }
        return  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: donationLists,
          );
                      }
    );
  }
}