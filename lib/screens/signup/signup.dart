import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/firebase_auth.dart';
import '../../components/HrDivider.dart';
import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
import '../../components/HaveAnAccount.dart';
import '../../components/SocialIcons.dart';
import '../login/login.dart';
import './SignUpBackground.dart';

class SignUp extends StatelessWidget {
  static const id = 'signup';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SignUpBackground(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SIGN UP',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                'assets/icons/signup.svg',
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
                text: 'SIGN UP',
                onPress: () {},
              ),
              SizedBox(height: size.height * 0.03),
              HaveAnAccountCheck(
                login: false,
                onPress: () {
                  Navigator.pushNamed(context, Login.id);
                },
              ),
              HrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSource: 'assets/icons/google-plus.svg',
                    onPress: () async {
                      bool res = await AuthProvider().loginWithGoogle();
                      if (!res) print('Error with Google');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
