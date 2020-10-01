import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/timeline.dart';

import '../../provider/user_provider.dart';
import '../../models/usertransactionmodel.dart';
import '../../routes.dart';
import '../../theme/extention.dart';
import '../../constants.dart';

//transaction card
class UserTransactionCard extends StatelessWidget {
  final UserTransactionModel transaction;
  UserTransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    DateTime date = transaction.time.toDate();
    String time = DateFormat('dd MMM yyyy').format(date);
    double donatedamount = transaction.amount;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double height = queryData.size.height * 0.007;
    double cardWidth = MediaQuery.of(context).size.width * 0.9;
    double width = cardWidth * 0.035;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Timeline.setDate(date),
          style: kTransactionCardBoxText,
        ),
        SizedBox(
          height: queryData.size.height * 0.007,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: height),
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: kHomeDecoration,
          padding: EdgeInsets.all(width),
          child: Container(
            width: cardWidth * 1,
            child: Row(children: <Widget>[
              FittedBox(
                child: Container(
                  width: cardWidth * 0.12,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(transaction.doneeImage),
                  ),
                ),
              ),
              SizedBox(
                width: cardWidth * 0.03,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: cardWidth * 0.45,
                child: FittedBox(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: cardWidth * 0.45,
                          child: FittedBox(
                            child: Row(children: <Widget>[
                              FittedBox(
                                child:
                                    Text('to:', style: kTransactionCardBoxText),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              FittedBox(
                                child: Text(transaction.donee,
                                    style: kTransactionCardDoneeBoxText),
                              ),
                            ]),
                          ),
                        ),
                        FittedBox(
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            direction: Axis.vertical,
                            children: [
                              Text(transaction.donor,
                                  style: kDetailTransactionCardText),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text('$time', style: kDetailTransactionCardText),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                width: cardWidth * 0.05,
              ),
              Container(
                alignment: Alignment(1.0, 0.0),
                width: cardWidth * 0.3,
                child: FittedBox(
                  child: Text(
                    'Rs $donatedamount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFA2E69),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    ).ripple(() {
      final user = Provider.of<UserProvider>(context, listen: false);
      if (transaction.donorId == user.id)
        Navigator.pushNamed(context, Routes.donation_detail,
            arguments: transaction);
    });
  }
}
