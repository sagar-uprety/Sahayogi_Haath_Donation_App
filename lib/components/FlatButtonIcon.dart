import 'package:flutter/material.dart';
import 'package:sahayogihaath/theme/light_color.dart';
// import 'package:sahayogihaath/theme/theme.dart';
import '../theme/extention.dart';

class FlatButtonIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPress;
  final Color color;
  const FlatButtonIcon({
    @required this.text,
    this.icon = Icons.sort,
    this.onPress,
    this.color = LightColor.background,
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
