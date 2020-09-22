import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/RoundedButton.dart';
import '../components/RoundedInput.dart';
import '../provider/auth_provider.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email;

    return Container(
      color: Color(0xff757575),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Reset Your Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedInput(
                  hintText: 'Your Email',
                  key: ValueKey('email'),
                  enableSuggesstion: false,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  autofocus: true,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value;
                    print(email);
                  },
                ),
                RoundButton(
                  text: 'Reset Password',
                  onPress: () {
                    final isValid = _formKey.currentState.validate();
                    FocusScope.of(context).unfocus();

                    print(email);

                    if (isValid) {
                      _formKey.currentState.save();
                      Provider.of<AuthProvider>(context, listen: false)
                          .sendPasswordResetEmail(email, context);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
