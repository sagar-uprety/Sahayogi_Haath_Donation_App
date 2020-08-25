import 'package:firebase_auth/firebase_auth.dart';
import '../../components/transaction_components/sortByDate.dart';
import '../../components/transaction_components/search_bar.dart';
import '../transactioncardCreator.dart';
import 'package:flutter/material.dart';

class OrganizationTransaction extends StatefulWidget {
  static const id = 'organizationtransaction';
  @override
   _OrganizationTransaction createState() =>  _OrganizationTransaction();
}

class  _OrganizationTransaction extends State< OrganizationTransaction> {
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  void getCurrentUser() async{
    try{
      final user=await _auth.currentUser();

      if(user != null){
        loggedInUser=user;
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width*0.02;
     return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(width),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SearchBar(),
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.015,
                ),
                SortByList(queryData: queryData),
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.015,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width ),
                  child: DonationStream(),
                ),  
              ]
            ),
          ),
        ),
      ),
    );
  }
}









