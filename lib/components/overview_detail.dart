import 'package:flutter/material.dart';
import '../constants.dart';

class OverviewDetail extends StatelessWidget {

  OverviewDetail({@required this.info,@required this.title});

  final dynamic info;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$info',
          style: tOverviewHeadStyle.copyWith(fontSize: size.width*0.055),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '$title',
          style: tOverviewTitleStyle.copyWith(fontSize: size.width*0.028),
        ),
      ],
    );
  }
}