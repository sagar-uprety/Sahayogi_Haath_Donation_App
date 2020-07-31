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

class SignUp extends StatefulWidget {
  static const id = 'signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  

  void _submit() {
    final isValid = _formKey.currentState.validate();
    // FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
     
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SignUpBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  key: ValueKey('email'),
                  hintText: "Enter Your Email",
                  capitalization: TextCapitalization.none,
                  enableSuggesstion: false,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                RoundedInput(
                  key: ValueKey('password'),
                  hintText: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  suffixIcon: Icons.visibility,
                  onSaved: (value) {
                    _userPassword = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                RoundButton(
                  text: 'SIGN UP',
                  onPress: _submit,
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
      ),
    );
  }
}
