import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider/extras_provider.dart';

import '../provider/user_provider.dart';
import '../routes.dart';
import '../models/usermodel.dart';
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

  FirebaseUser user;

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
      File profileImage,
      UserType userType,
      String establishedDate,
      String type,
      File documentImage,
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
                image: profileImage, path: CloudPath.profile, id: uid)
            .then((String value) {
          imageUrl = value;
        });

        String documentUrl;

        if (userType == UserType.organization) {
          await ImageUploader()
              .uploadImage(
                  image: documentImage, path: CloudPath.document, id: uid)
              .then((String value) {
            documentUrl = value;
          });
        }

        final userDatabase = Provider.of<UserProvider>(ctx,listen: false);

        if (userType == UserType.donor) {
          userDatabase.registerDonor(
              DonorModel(
                  id: uid,
                  name: name,
                  email: email,
                  address: address,
                  phone: phone,
                  profileImage: imageUrl,
                  isDonor: true,
                  isAdmin: false,
                )
          );
        } else if (userType == UserType.organization) {
          userDatabase.registerOrganization(
            OrganizationModel(
                id: uid,
                name: name,
                email: email,
                address: address,
                phone: phone,
                establishedDate: establishedDate,
                profileImage: imageUrl,
                type: type,
                documentImage: documentUrl,
                isOrganization: true,
              )
          );
        }
        Provider.of<ExtrasProvider>(ctx,listen: false).saveIdName(uid,name);
        sendEmailVerification(ctx);
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

  Future signInWithEmailAndPassword(
      String email, String password, BuildContext ctx) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      sendEmailVerification(ctx);
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
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  Future sendEmailVerification(BuildContext ctx) async {
    try {
      user = await _auth.currentUser();
      if (!user.isEmailVerified) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(
                'Please verify your email first and then try logging in again.'),
            backgroundColor: Colors.red[600],
          ),
        );

        await user
            .sendEmailVerification()
            .whenComplete(() => print('Mail Sent'))
            .catchError((e) {
          Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text(
                  'Error sending mail. Make sure the email address is correct and please try again later.'),
              backgroundColor: Colors.red[600],
            ),
          );
        });

        await signOut();

        Navigator.of(ctx).pushReplacementNamed(Routes.login);
      } else {
        print('Verified User');
        Navigator.of(ctx).pushReplacementNamed(Routes.dashboard);
      }
    } catch (e) {
      print(e);
    }
  }

  Future sendPasswordResetEmail(email, ctx) async {
    await _auth.sendPasswordResetEmail(email: email).whenComplete(() {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content:
              Text('A link to reset the password has been sent to your email.'),
          backgroundColor: Colors.green[600],
        ),
      );
    }).catchError((error) {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
              'Error sending mail. Make sure the email address is correct and please try again later.'),
          backgroundColor: Colors.red[600],
        ),
      );
    });
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    user = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
