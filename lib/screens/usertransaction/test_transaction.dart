import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../../models/usertransactionmodel.dart';
import '../../screens/usertransaction/edit_transaction.dart';
class TransactionTest extends StatefulWidget {
  // final List listprovider;
  // final int itemCount;
  // final double heightPercent;
  // final double hm;
  @override
  _TransactionTestState createState() => _TransactionTestState();
}

class _TransactionTestState extends State<TransactionTest> {
  @override
  void initState() {
    getUserData().then((value) {
      print("SuccessFul");
    });
    

    super.initState();
  }
  getUserData() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getUserData();
  }
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<UserTransactionModel>>(context,listen: false);
    print(transactions);

    return Scaffold(
        appBar: AppBar(
          title: Text('Transaction'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditTransaction()));
              },
            )
          ],
        ),
        body: (transactions != null)
            ?  ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(transactions[index].donor),
                    trailing: Text(transactions[index].donee),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditTransaction(transactions[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator())
            
    );
  }
}
