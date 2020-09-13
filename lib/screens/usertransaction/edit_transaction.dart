import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/usertransaction_provider.dart';
import 'package:sahayogihaath/models/usertransactionmodel.dart';
class EditTransaction extends StatefulWidget {
  final UserTransactionModel transaction;

  EditTransaction([this.transaction]);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final usernameController = TextEditingController();
  final orgnameController = TextEditingController();
   //final amountController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    orgnameController.dispose();
    //amountController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    if (widget.transaction == null) {
      //New Record
          usernameController.text = "";
          orgnameController.text = "";
          //amountController.text = "";
        new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<UserTransactionProvider>(context,listen: false);
        productProvider.loadValues(UserTransactionModel());
      });
    } else {
      //Controller Update
      usernameController.text=widget.transaction.donor;
      orgnameController.text=widget.transaction.donee;
      //amountController.text=widget.transaction.amount.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<UserTransactionProvider>(context,listen: false);
        productProvider.loadValues(widget.transaction);
      });
      
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<UserTransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(hintText: 'User Name'),
              onChanged: (value) {
                transactionProvider.changeDonor(value);
              },
            ),
            TextField(
              controller: orgnameController,
              decoration: InputDecoration(hintText: 'Organization Name'),
              onChanged: (value) => transactionProvider.changeDonee(value),
            ),
            // TextField(
            //   controller: amountController,
            //   decoration: InputDecoration(hintText: 'Amount'),
            //   onChanged: (value) => transactionProvider.changeAmount(value),
            // ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () async {
                await transactionProvider.saveTransaction();
                Navigator.of(context).pop();
              },
            ),
            (widget.transaction !=null) ? 
            RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Delete'),
              onPressed: () {
                transactionProvider.removeTransaction(widget.transaction.transactionId);
                Navigator.of(context).pop();
              },
            )
            : Container(),
          ],
        ),
      ),
    );
  }
}