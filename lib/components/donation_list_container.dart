import 'package:flutter/material.dart';
import '../constants.dart';

class DonationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;

    return Container(
      decoration: cHomeListContainerDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  // backgroundImage: AssetImage('images/$donorImage'),
                  radius: size.width*0.046,
                ),
                SizedBox(
                  width: size.width*0.023,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'to: ',
                          style: tRecentsText1Theme.copyWith(fontSize: size.width*0.035),
                        ),
                        Text(
                          'Chris Pratt',
                          style: tRecentsText2Theme.copyWith(fontSize: size.width*0.042),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: size.width*0.24,
                          child: Text(
                            'Chris Hems...',
                            style: tRecentsText1Theme.copyWith(fontSize: size.width*0.035),
                          ),
                        ),
                        SizedBox(
                          width: size.width*0.06,
                        ),
                        Text(
                          '5 Minutes ago',
                          style: tRecentsText1Theme.copyWith(fontSize: size.width*0.035),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            'Rs. 1000',
            style: tRecentsAmountTheme.copyWith(fontSize: size.width*0.046),
          )
        ],
      ),
    );
  }
}

