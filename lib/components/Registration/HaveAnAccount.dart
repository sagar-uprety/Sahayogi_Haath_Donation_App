import 'package:flutter/material.dart';
import '../../constants.dart';

class HaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function onPress;
  const HaveAnAccountCheck({
    Key key,
    this.login = true,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? 'Don\'t have an Account?' : 'Already have an Account?',
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: onPress,
          child: Text(
            login ? ' Sign Up' : ' Login',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
