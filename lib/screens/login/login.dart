import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../screens/forgot_password.dart';
import '../../routes.dart';
import '../../provider/auth_provider.dart';
import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
import '../../components/HaveAnAccount.dart';
import './LoginBackground.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var userEmail = '';
  var userPassword = '';

  bool obscurePassword= true;

  void _toggleVisibility(){
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

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
                obscureText: obscurePassword,
                suffixIcon: obscurePassword ? Icons.visibility : Icons.visibility_off,
                onClickedSuffixIcon: _toggleVisibility,
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
              authProvider.status == Status.Authenticating ? CircularProgressIndicator() :
                RoundButton(
                  text: 'LOGIN',
                  onPress: ()async{
                    final isValid = _formKey.currentState.validate();
                    FocusScope.of(context).unfocus();
                
                    if(isValid){
                      _formKey.currentState.save();
                      await authProvider.signInWithEmailAndPassword(userEmail.trim(), userPassword.trim(), context).catchError((error){
                        print(error);
                      });
                    }
                  },
                ),
              SizedBox(height: size.height * 0.03),
              if (authProvider.status != Status.Authenticating)
                HaveAnAccountCheck(
                  onPress: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                ),
              if (authProvider.status != Status.Authenticating)
                FlatButton(
                  textColor: Colors.blue,
                  onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ForgotPassword(),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
