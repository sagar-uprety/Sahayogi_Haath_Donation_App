
import 'package:flutter/material.dart';

import './signup.dart';

class SignUpMain extends StatefulWidget {
  @override
  _SignUpMainState createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUp(),
    );
  }
}