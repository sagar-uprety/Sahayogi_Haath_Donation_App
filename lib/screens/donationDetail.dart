import 'package:flutter/material.dart';
import '../constants/transaction_const.dart';
class DonationDetail extends StatefulWidget {
  static const id = 'donationDetail';
  @override
  _DonationDetailState createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DonationDetail> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double height =  queryData.size.height*0.03;
    double cardWidth = MediaQuery.of(context).size.width*0.9;
    double width = queryData.size.width*0.08;
    return SafeArea(
      child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height,horizontal: width),
              width:cardWidth,
              height:MediaQuery.of(context).size.height*0.07,
              decoration:kHomeDecoration,
              child:Center(child: Text('Donation Detail')), 
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width),
              padding: EdgeInsets.all(queryData.size.width*0.05),
              width:cardWidth,
              height:MediaQuery.of(context).size.height*0.5,
              decoration: kHomeDecoration,
              child: Column(
                children: <Widget> [
                  FittedBox(
                    child: Row(
                      children: [
                        Container(),
                        Text('Dara')
                      ],
                    ),
                  ),
                  MaterialButton(
                    child: Text('View'),
                    onPressed: null,
                  ),
                  Row(),
                  Column(),
                ]
              ),
            )
        ],
      ),
          ),
    );
  }
}