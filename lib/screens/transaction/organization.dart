import '../../components/transaction_components/Organization/dropdown.dart';
import '../../components/transaction_components/search_bar.dart';
import '../../components/transaction_components/Organization/transactioncardCreator.dart';
import 'package:flutter/material.dart';

class OrganizationTransaction extends StatefulWidget {
  static const id = 'organizationtransaction';
  @override
   _OrganizationTransaction createState() =>  _OrganizationTransaction();
}

class  _OrganizationTransaction extends State< OrganizationTransaction> {
   TransactionCardCreator cardCreator = TransactionCardCreator();
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
                  child: cardCreator.donationData()
                ),  
              ]
            ),
          ),
        ),
      ),
    );
  }
}









