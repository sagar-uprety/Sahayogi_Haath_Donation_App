import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/ListTiles/DonationListTiles.dart';
import '../../../models/usertransactionmodel.dart';

import '../../../theme/text_styles.dart';
import '../../../theme/extention.dart';

class TabDonations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Received Donations", style: TextStyles.title.bold),
              IconButton(
                      icon: Icon(
                        Icons.sort,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {})
                  .p(15)
            ],
          ).hP16,
          _transactionTile(context).vP8,
        ],
      ),
    );
  }

  
  Widget _transactionTile(BuildContext context) {
    final transactions = Provider.of<List<UserTransactionModel>>(context);
    return (transactions != null)
        ? DonationListTiles(
            listprovider: transactions,
            itemCount: transactions.length,
            heightPercent: 0.7, //from 0 to 1
          )
        : Center(child: CircularProgressIndicator());
  }
}
