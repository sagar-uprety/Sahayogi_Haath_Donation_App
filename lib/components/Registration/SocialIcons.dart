import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconSource;
  final Function onPress;
  const SocialIcon({
    Key key,
    this.iconSource,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSource,
          height: 20.0,
          width: 20.0,
        ),
      ),
    );
  }
}
