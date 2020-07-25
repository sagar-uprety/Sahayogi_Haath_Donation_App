import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/RoundedButton.dart';
import '../../constants.dart';
import './background.dart';

class Welcome extends StatelessWidget {
  static const id = 'welcome';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'WELCOME TO SAHAYOGI HAATH',
                style: TextStyle(fontWeight: FontWeight.w900), //fix this
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                'assets/icons/chat.svg',
                height: size.height * 0.4,
              ),
              SizedBox(height: size.height * 0.05),
              RoundButton(
                text: 'Login',
                press: () {},
              ),
              RoundButton(
                text: 'Sign Up',
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
