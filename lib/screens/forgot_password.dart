import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/RoundedButton.dart';
import '../components/RoundedInput.dart';
import '../provider/auth_provider.dart';
import '../theme/extention.dart';

class ForgotPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String email;
    bool isValid = false;

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
                    isValid = true;
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
                    FocusScope.of(context).unfocus();

                    print(email);

                    if (isValid) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .sendPasswordResetEmail(email, context);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ).p16,
          )),
    );
  }
}
