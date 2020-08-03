import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/HrDivider.dart';
import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
import '../../components/HaveAnAccount.dart';
import '../../components/SocialIcons.dart';
import '../login/login_main.dart';
import './SignUpBackground.dart';

class SignUp extends StatefulWidget {
  SignUp(this.submitSignUpForm, this.loginWithGoogle);

  final void Function(
    String email,
    String password,
  ) submitSignUpForm;

  final Future<bool> Function() loginWithGoogle;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var userEmail = '';
  var userPassword = '';
  // var _userName = '';
  void _submit() {
    final isValid = _formKey.currentState.validate();
    // FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitSignUpForm(
        userEmail,
        userPassword,
      );
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
                  hintText: "Enter Your Email",
                  key: ValueKey('email'),
                  enableSuggesstion: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userEmail = value;
                    print(userEmail);
                  },
                ),
                RoundedInput(
                  hintText: "Password",
                  key: ValueKey('password'),
                  icon: Icons.lock,
                  obscureText: true,
                  suffixIcon: Icons.visibility,
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userPassword = value;
                    print(userPassword);
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
                    Navigator.pushNamed(context, LoginMain.id);
                  },
                ),
                HrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSource: 'assets/icons/google-plus.svg',
                      onPress: () async {
                        bool res = await widget.loginWithGoogle();
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
