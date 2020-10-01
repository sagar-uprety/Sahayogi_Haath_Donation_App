import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/usertransactionmodel.dart';
import '../../constants.dart';
import '../../theme/extention.dart';

class DonationDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final UserTransactionModel transaction = ModalRoute.of(context).settings.arguments;
    DateTime date = transaction.time.toDate();
    String datetime = DateFormat('dd MMM yyyy').format(date);
    double donatedamount = transaction.amount;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double height = queryData.size.height * 0.03;
    double cardWidth = MediaQuery.of(context).size.width * 0.9;
    double width = queryData.size.width * 0.08;
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: height, horizontal: width),
            width: cardWidth,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: kTransactionDetail,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.monetization_on,
                  color: Colors.purple[50],
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Transaction Detail',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            )),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: width),
              width: cardWidth,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: kHomeDecoration,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(transaction.doneeImage),
                            backgroundColor: Colors.blue,
                            radius: 20,
                          ),
                          SizedBox(
                            width: queryData.size.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.donee,
                                style: kTransactionCardDoneeBoxText,
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.005,
                              ),
                              Text('$datetime',
                                  style: kDetailTransactionCardText)
                            ],
                          ),
                          SizedBox(
                            width: queryData.size.width * 0.2,
                          ),
                          Text(
                            'Rs $donatedamount',
                            style: kAmount,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Channel',
                                style: kTransactionCardBoxText,
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.005,
                              ),
                              Text(
                                'Esewa Payment',
                                style: kTransactionCardDoneeBoxText,
                              ),
                            ]),
                        SizedBox(
                          height: queryData.size.height * 0.04,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction Code',
                                style: kTransactionCardBoxText,
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.005,
                              ),
                              Text(
                                transaction.transactionId,
                                style: kTransactionCardDoneeBoxText,
                              ),
                            ]),
                        SizedBox(
                          height: queryData.size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Donated By',
                                    style: kTransactionCardBoxText,
                                  ),
                                  SizedBox(
                                    height: queryData.size.height * 0.005,
                                  ),
                                  Text(
                                    transaction.donor,
                                    style: kTransactionCardDoneeBoxText,
                                  ),
                                ]),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(transaction.donorImage),
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                ),
                          ],
                        ),
                      ],
                    ),
                  ]).p(20)),
        ],
      ).p(2)),
    );
  }
}
