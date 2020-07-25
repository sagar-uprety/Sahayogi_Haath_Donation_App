import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahayogihaath/screens/signup/signup.dart';
import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
import '../../components/HaveAnAccount.dart';
import './LoginBackground.dart';

class Login extends StatelessWidget {
  static const id = 'login';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'LOGIN',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                'assets/icons/login.svg',
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInput(
                hintText: "Enter Your Email",
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              RoundedInput(
                hintText: "Password",
                icon: Icons.lock,
                obscureText: true,
                suffixIcon: Icons.visibility,
                onChanged: (value) {},
              ),
              RoundButton(
                text: 'LOGIN',
                onPress: () {},
              ),
              SizedBox(height: size.height * 0.03),
              HaveAnAccountCheck(
                onPress: () {
                  Navigator.pushNamed(context, SignUp.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
