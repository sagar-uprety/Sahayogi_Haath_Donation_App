import 'package:flutter/material.dart';
import '../../constants/transaction_const.dart';
//transaction card
class TransactionCard extends StatelessWidget {
   String day;
   String donee;
   String donor;
   String time;
   double amount;
  String donorImage;
  TransactionCard({this.day,@required this.donor, @required this.donee, @required this.time, @required this.donorImage, @required this.amount});
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double height =  queryData.size.height*0.007;
    double cardWidth = MediaQuery.of(context).size.width*0.9;
    double width = cardWidth*0.035;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('$day', style: kTransactionCardBoxText,),
        SizedBox(
                    height: queryData.size.height*0.007,
                  ),
        Container(
              margin: EdgeInsets.symmetric(vertical: height),
              width:MediaQuery.of(context).size.width*0.95,
              height:MediaQuery.of(context).size.height*0.1,
              decoration:kHomeDecoration,
              padding: EdgeInsets.all(width),
              child: Container(
                 width: cardWidth*1,
                child: Row(
                  children: <Widget>[
                  FittedBox(
                    child: Container(
                      width: cardWidth*0.12,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://image.shutterstock.com/image-photo/mountains-during-sunset-beautiful-natural-260nw-407021107.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth*0.03,
                  ),
                  Container(
                    width: cardWidth*0.35,
                    child: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  'to:',
                                  style: kTransactionCardBoxText
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.02,
                              ),
                              FittedBox(
                                child: Text(
                                  donee, 
                                  style: kTransactionCardDoneeBoxText
                                ),
                              ),
                            ]
                          ),
                          FittedBox(
                            child: Wrap(
                               alignment: WrapAlignment.spaceBetween,
                               direction: Axis.vertical,
                               children: [
                                Text( 
                                    donor, 
                                    style:kDetailTransactionCardText
                                  ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.02,
                                ),
                                Text(
                                  '$time',
                                  style: kDetailTransactionCardText
                                ),
                              ],
                            ),
                          ),
                          
                        ]
                      ),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth*0.05,
                  ),
                    Container(
                      alignment: Alignment(1.0,0.0),
                      width: cardWidth*0.40,
                      child: FittedBox(
                              child: Text('Rs $amount',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:FontWeight.bold,
                                  color: Color(0xFFFA2E69),
                                ),
                              ),
                            ),
                    ),  
                  ]
                  
                ),
              ),
                  
        
        ),
        SizedBox(
                    height: height*0.02,
                  ),
      ],
    );
  }
}


