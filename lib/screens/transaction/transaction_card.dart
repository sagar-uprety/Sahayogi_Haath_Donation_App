import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../constants/transaction_const.dart';
//transaction card
class TransactionCard extends StatelessWidget {
   DateTime day;
   String donee;
   String donor;
   String time;
   double amount;
  String donorImage;
  TransactionCard({this.day,@required this.donor, @required this.donee, @required this.time, @required this.donorImage, @required this.amount});
  
                      
String setDate(DateTime day){
  
  DateTime now = DateTime.now();
  int day1 = now.difference(day).inDays;
  int day2 = int.parse(DateFormat('H').format(day));
  final today = DateTime(now.year, now.month, now.day);
  var timeAgo = day1.toString();
  String ago ;
  if(day == today){
    ago = 'Today';
  }
  else if(day1 == 0){
    if(day2 >12 && day2< 24){
      ago = 'Yesterday';
    }
    else{
      ago = 'Today';
    }
  }
  else if(day1 == 1 && day1 < 2){
    if(day2 > 12 && day2< 24){
      var timeToday = day1+1; 
      print(timeToday);
      ago = timeToday.toString() + ' days ago';
    }
    else{
      ago = 'Yesterday';
    }
  }
  else if(day1 < 30 && day1 > 2){
    ago = '$timeAgo days ago';
  } 

  else if(day1 >=30 && day1<=32){
    ago = ' 1 month ago';
  }
  else{
    ago = 'Few months ago';
  }
  return(ago);       
}
  
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
        Text(setDate(day), style: kTransactionCardBoxText,),
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


