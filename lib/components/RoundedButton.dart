import 'package:flutter/material.dart';
import '../constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final Function onPress;
  const RoundButton({
    Key key,
    @required this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          color: color,
          onPressed: onPress,
          child: Text(text,
              style: TextStyle(
                color: textColor,
              )),
        ),
      ),
    );
  }
}
