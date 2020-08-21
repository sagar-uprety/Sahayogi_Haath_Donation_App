import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
import '../../components/Registration/HaveAnAccount.dart';
import '../signup/signup_main.dart';
import './LoginBackground.dart';

class Login extends StatefulWidget {
  Login(this.submitLoginForm, this.loginWithGoogle, this.isLoading);

  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) submitLoginForm;
  final Future<bool> Function() loginWithGoogle;

  final bool isLoading;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var userEmail = '';
  var userPassword = '';

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitLoginForm(
        userEmail.trim(),
        userPassword.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                key: ValueKey('email'),
                icon: Icons.person,
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
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                RoundButton(
                  text: 'LOGIN',
                  onPress: _submit,
                ),
              SizedBox(height: size.height * 0.03),
              if (!widget.isLoading)
                HaveAnAccountCheck(
                  onPress: () {
                    Navigator.pushNamed(context, SignUpMain.id);
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
