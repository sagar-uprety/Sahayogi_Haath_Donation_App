
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider/usertransaction_provider.dart';
import 'package:sahayogihaath/screens/dashboard/dashboard.dart';

import '../../components/transaction_components/search_bar.dart';
import '../../components/transaction_components/showtransactionButton.dart';
import '../../components/transaction_components/usertransaction_card.dart';

import '../../provider/user_provider.dart';
import '../../models/usertransactionmodel.dart';


enum MyChoice {
  my,
  all,
}

class UserTransaction extends StatefulWidget {
 
  static const id = 'usertransaction';
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  
  MyChoice selectedChoice;
  bool isLoading = true;



 
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
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget> [
                   SearchBar(),
                     SizedBox(
                         height:MediaQuery.of(context).size.height*0.015,
                       ),
                     Container(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           ShowTransactionButton(
                             onpressed: (){
                               setState(() {
                               selectedChoice = MyChoice.my;
                               });
                             },
                             text: 'My',
                             colour: selectedChoice == MyChoice.my ? Color(0xFFC4C4C4) : Colors.white,
                             fontcolour: selectedChoice == MyChoice.my ? Colors.white : Colors.black,
                             leftSide: 6,
                             rightSide: 0,
                           ),
                           ShowTransactionButton(
                             onpressed: (){
                               setState(() {
                                 selectedChoice = MyChoice.all;
                               });
                               
                             },
                             text: 'All',
                             colour: selectedChoice == MyChoice.all ? Color(0xFFC4C4C4) : Colors.white,
                             fontcolour: selectedChoice == MyChoice.all ? Colors.white : Colors.black,
                             rightSide: 6,
                             leftSide: 0,
                           ),
                           
                         ],
                       )
                     ),
                     SizedBox(
                         height:MediaQuery.of(context).size.height*0.015,
                       ),
                      _donationList(),
                   ]
                 ),
               ) 
      ),
    )
     );
  }

  Widget _donationList(){
  final transactions = Provider.of<List<UserTransactionModel>>(context);
    return (transactions != null)? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                             itemCount: transactions.length,
                             itemBuilder: (context, index) {
                               return UserTransactionCard(
                                     donor: transactions[index].donor, 
                                     donee: transactions[index].donee, 
                                     time: transactions[index].time, 
                                     donorImage: transactions[index].donorImage, 
                                     amount: transactions[index].amount,
                                   );
                             }
                  )
                      : Center(child: CircularProgressIndicator());
  }
}
