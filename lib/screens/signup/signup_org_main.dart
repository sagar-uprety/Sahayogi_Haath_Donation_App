import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/services.dart';
import '../dashboard/dashboard_main.dart';
import './signup_org.dart';

class SignUpOrganizationMain extends StatefulWidget {
  static const id='signuporganizer';
  @override
  _SignUpOrganizationMainState createState() => _SignUpOrganizationMainState();
}

class _SignUpOrganizationMainState extends State<SignUpOrganizationMain> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitSignUpForm(
    String email,
    String password,
    String name,
    String phone,
    String address,
    String establishedDate,
    String type,
    File userImage,
    File document,
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

      final profile = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(authResult.user.uid + '.jpg');

      await profile.putFile(userImage).onComplete;
      final profileImageURL = await profile.getDownloadURL();

      final document = FirebaseStorage.instance
          .ref()
          .child('documents')
          .child(authResult.user.uid + '.jpg');

      await document.putFile(userImage).onComplete;
      final documentImageURL = await document.getDownloadURL();

      await Firestore.instance
          .collection('organizations')
          .document(authResult.user.uid)
          .setData({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'established_date': establishedDate,
        'type': type,
        'profile_url': profileImageURL,
        'document_url': documentImageURL,
      });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpOrganization(_submitSignUpForm, _isLoading),
    );
  }
}