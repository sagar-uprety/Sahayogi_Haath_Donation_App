import '../../constants/transaction_const.dart';
import '../../components/transaction_components/search_bar.dart';
import '../../components/transaction_components/Admin/dropdown.dart';
import 'package:flutter/material.dart';
import '../../components/transaction_components/Admin/transactioncardCreator.dart';

class AdminTransaction extends StatefulWidget {
  static const id = 'admintransaction';
  @override
  _AdminTransactionState createState() => _AdminTransactionState();
}
  
class _AdminTransactionState extends State<AdminTransaction> {    
  TransactionCardCreator cardCreator = TransactionCardCreator();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width*0.02;
    double height = queryData.size.width*0.03;
     return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(width) ,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SearchBar(),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                ),
                OrganizationName(queryData: queryData),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width ),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0x66A6AAB4),
              ),
                  padding: EdgeInsets.symmetric(horizontal:width, vertical: height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column( 
                        children: <Widget>[
                          Text('Rs 1500', style: kAdminTransactionCard,),
                          SizedBox(
                            height: height,
                          ),
                          Text('Total donation'),
                        ]
                      ),
                       Column( 
                        children: <Widget>[
                          Text('3', style: kAdminTransactionCard,),
                          SizedBox(
                            height: height,
                          ),
                          Text('Donations'),
                        ]
                      ),
                      CircleAvatar(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/download.jpg'),
                          radius: 45,
                        ),
                        backgroundColor: Color(0xFFFFFFFF),
                        
                        radius: 50,
                      )
                    ],
                  )
                ),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width ),
                  child: cardCreator.donationData(),
                ),  
              ]
            ),
          ),
        ),
      ),
    );
  }
}