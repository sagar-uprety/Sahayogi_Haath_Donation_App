import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayogihaath/screens/Activities/Activities.dart';
import 'package:sahayogihaath/screens/Activities/product.dart';

class Dashboard extends StatelessWidget {
  static const id = 'dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Dashboard',
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ActivitiesScreen.id);
            },
            child: Text('Create Activites'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Products.id);
            },
            child: Text('See Activites'),
          ),
          RaisedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
