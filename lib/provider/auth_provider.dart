import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import '../image_upload.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth;

  Status _status = Status.Uninitialized;

  Status get status => _status;

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> registerWithEmailAndPasword(
      {String name,
      String email,
      String password,
      String phone,
      String address,
      File profileUrl,
      String userType,
      BuildContext ctx}) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String uid = authResult.user.uid;
      if (uid != null) {
        String imageUrl;
        await ImageUploader()
            .uploadImage(
                image: profileUrl, path: CloudPath.profile, userId: uid)
            .then((String value) {
          imageUrl = value;
        });

        await Firestore.instance.collection('users').document(uid).setData({
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
          'profile_url': imageUrl,
          'user_type': 'donor',
          'isAdmin': false,
        });
      }
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
      _status = Status.Unauthenticated;
      notifyListeners();
    } catch (err) {
      print(err);
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password, BuildContext ctx) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
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
      _status = Status.Unauthenticated;
      return false;
    } catch (e) {
      print("Error on the sign in = " +e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
