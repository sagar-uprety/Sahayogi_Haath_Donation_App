import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahayogihaath/screens/signup/signup.dart';
import '../login/login.dart';
import '../../components/RoundedButton.dart';
import '../../constants.dart';
import './WelcomeBackground.dart';

class Welcome extends StatelessWidget {
  static const id = 'welcome';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: WelcomeBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'WELCOME TO SAHAYOGI HAATH',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: size.height * 0.022), //fix this
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                'assets/icons/chat.svg',
                height: size.height * 0.4,
              ),
              SizedBox(height: size.height * 0.05),
              RoundButton(
                text: 'Login',
                onPress: () {
                  Navigator.pushNamed(context, Login.id);
                },
              ),
              RoundButton(
                text: 'Sign Up',
                color: kPrimaryLightColor,
                textColor: Colors.black,
                onPress: () {
                  Navigator.pushNamed(context, SignUp.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
