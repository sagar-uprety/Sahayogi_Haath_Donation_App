import 'package:flutter/material.dart';
class ShowTransactionButton extends StatelessWidget {
final Function onpressed;
final Color colour;
final Color fontcolour;
final String text;
final double leftSide;
final double rightSide; 

ShowTransactionButton({this.colour, this.onpressed, this.fontcolour, this.text, this.leftSide, this.rightSide});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
    onPressed: onpressed,
      child: Text(text, style: TextStyle(
        fontSize: 18,
        color: fontcolour,
      ),),
      color: colour,
      shape: RoundedRectangleBorder(
        
          borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(leftSide),
          bottomLeft: Radius.circular(leftSide),
          topRight: Radius.circular(rightSide),
        bottomRight: Radius.circular(rightSide)
      ),
      side: BorderSide(color: Color(0xFFC4C4C4))
      ),
    );
  }
}