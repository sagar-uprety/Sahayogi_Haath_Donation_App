import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../dashboard/dashboard_main.dart';
import './signup.dart';

class SignUpMain extends StatefulWidget {
  static const id = 'signupmain';
  @override
  _SignUpMainState createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var _isLoading = false;

  void _submitSignUpForm(
    String email,
    String password,
    String name,
    String phone,
    String address,
    File userImage,
    BuildContext ctx,
  ) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });

      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(authResult.user.uid + '.jpg');

      await ref.putFile(userImage).onComplete;
      final url = await ref.getDownloadURL();

      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'profile_url': url,
        'user_type': 'donor',
        'isAdmin': false,
      });
      
      //TODO: This should be auto handled by authStateChanged
      Navigator.pushReplacementNamed(context, DashboardMain.id);
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red[600],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

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
      body: SignUp(_submitSignUpForm, loginWithGoogle, _isLoading),
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