import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usertransactionmodel.dart';
import '../../provider/usertransaction_provider.dart';



import '../../components/transaction_components/usertransaction_card.dart';
class UserTransactionMain extends StatelessWidget {
  String userid;
  DateTime selectedDate;
  DateTime endDate;
  UserTransactionMain({this.userid, this.selectedDate, this.endDate});
  @override
  Widget build(BuildContext context) {
      final transactionProvider = Provider.of<UserTransactionProvider>(context);
      transactionProvider.getSortedBy(userid,selectedDate,endDate);
     final transactions = Provider.of<List<UserTransactionModel>>(context);
    return (transactions != null)? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                             itemCount: transactions.length,
                             itemBuilder: (context, index) {
                               
                               return UserTransactionCard(
                                     donor: transactions[index].donor, 
                                     donee: transactions[index].donee, 
                                      datetime: transactions[index].time, 
                                     donorImage: transactions[index].donorImage, 
                                     amount: transactions[index].amount,
                                   );
                             }
                  )
                      : Center(child: CircularProgressIndicator());
  }
}