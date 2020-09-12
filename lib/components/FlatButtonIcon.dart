import 'package:flutter/material.dart';
import '../theme/extention.dart';

class FlatButtonIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPress;
  const FlatButtonIcon({
    @required this.text,
    this.icon = Icons.sort,
    this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Theme.of(context).backgroundColor,
      child: Row(children: [
        Text(
          text,
        ).hP8,
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        )
      ]),
      onPressed: () {},
    ).ripple(onPress, borderRadius: BorderRadius.circular(13));
  }
}
