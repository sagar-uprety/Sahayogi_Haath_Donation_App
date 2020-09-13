import 'package:flutter/material.dart';
import 'package:sahayogihaath/theme/theme.dart';
import '../constants.dart';
import '../theme/extention.dart';
import '../theme/text_styles.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final Function onPress;
  final double radius;
  const RoundButton({
    Key key,
    @required this.text,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.onPress,
    this.radius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
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

class NavigatingButton extends StatelessWidget {
  final String text;
  final Color color, textColor;
  final IconData icon;
  final Function onPress;
  final double radius;
  final bool hasNavigation;
  const NavigatingButton({
    Key key,
    @required this.text,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    @required this.onPress,
    this.radius = 30,
    this.hasNavigation =true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context) * 0.85,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [BoxShadow(color: Color(0xff000000), blurRadius: 8,offset: Offset(0, 5))],
        borderRadius: BorderRadius.circular(radius)
      ),
      child: ClipRRect(
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyles.title.copyWith(color: textColor)
            ),
            Spacer(),
            if(hasNavigation)
              Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
          ]
        ).p16
      ),
    ).ripple(onPress);
  }
}