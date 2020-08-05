import 'package:flutter/material.dart';
import '../constants.dart';

class ActivityContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(
      decoration: cHomeListContainerDecoration,
      padding: EdgeInsets.fromLTRB(8, 5, 10, 8),
      child: Row(
        children: <Widget>[
          Container(
            height: size.width*0.22,
            width: size.width*0.22,
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('images/helpinghands.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: size.height*0.122,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Clothes Distribution to Poor Kids in Kathmandu',
                    style: tRecentsText2Theme.copyWith(fontSize: size.width*0.042),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'By: Helping Hands',
                        style: tRecentsText1Theme.copyWith(fontSize: size.width*0.028),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width*0.347,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: Color(0xff999999),
                                  size: 15,
                                ),
                                Text(
                                  '5 September 2020',
                                  style: tRecentsText1Theme.copyWith(fontSize: size.width*0.028),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Color(0xff999999),
                                  size: 15,
                                ),
                                Text(
                                  '180',
                                  style: tRecentsText1Theme.copyWith(fontSize: size.width*0.028),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.comment,
                                  color: Color(0xff999999),
                                  size: 15,
                                ),
                                Text(
                                  '21',
                                  style: tRecentsText1Theme.copyWith(fontSize: size.width*0.028),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}