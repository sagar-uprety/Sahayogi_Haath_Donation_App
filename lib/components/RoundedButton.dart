import 'package:flutter/material.dart';
import '../constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final Function press;
  const RoundButton({
    Key key,
    @required this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: size.width * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(text,
              style: TextStyle(
                color: textColor,
              )),
        ),
      ),
    );
  }
}
