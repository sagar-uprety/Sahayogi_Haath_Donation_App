import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './signup.dart';

class SignUpMain extends StatefulWidget {
  static const id = 'signupmain';
  @override
  _SignUpMainState createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return false;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      if (user == null) return false;
      return true;
    } catch (e) {
      print(e.message);
      print('Errow with Google SignUp');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUp(loginWithGoogle),
    );
  }
}

// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// sendMail();
// try {
//   await authResult.user.sendEmailVerification();
//   print('mail sent.');
// } catch (e) {
//   print("An error occured.");
//   print(e.message);
// }

// Future<void> sendMail() async{
//   String username = 'ds.ed347@gmail.com';
//   String password = 'webleedblue';

//   SmtpServer smtpServer = SmtpServer('smtp.gmail.com',username: username,password: password, ssl: true, allowInsecure: false ,ignoreBadCertificate: true,);

//   final message= Message()
//     ..from= Address(username, "Dipesh Shrestha")
//     ..recipients.add('dipesh650@yahoo.com')
//     ..subject = 'This is the Subject.'
//     ..text = 'This is the text.'
//     ..html = "<h1>HTML</h1>";

//   try {
//     final SendReport sendReport = await send(message, smtpServer);
//     print(sendReport.toString());
//     print('Messeage sent.');
//   } on MailerException catch (e) {
//     print('Message not sent.');
//     print(e);
//   }
// }