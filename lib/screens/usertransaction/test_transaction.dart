import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usertransactionmodel.dart';
import '../../screens/usertransaction/edit_transaction.dart';
class TransactionTest extends StatefulWidget {
  
  @override
  _TransactionTestState createState() => _TransactionTestState();
}

class _TransactionTestState extends State<TransactionTest> {

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<UserTransactionModel>>(context);
    print(transactions);

    return Scaffold(
        appBar: AppBar(
          title: Text('Transaction'),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.add,
            //     size: 30.0,
            //   ),
            //   // onPressed: () {
            //   //   Navigator.of(context).push(
            //   //       MaterialPageRoute(builder: (context) => EditTransaction()));
            //   // },
            // )
          ],
        ),
        body: (transactions != null)
            ?  ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(transactions[index].amount),
                    // trailing: Text(transactions[index].donee),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => EditTransaction(transactions[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator())
            
    );
  }
}
