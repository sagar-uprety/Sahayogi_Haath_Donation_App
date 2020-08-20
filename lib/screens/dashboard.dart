import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayogihaath/screens/activities_screen/acitivity_list.dart';
import 'package:sahayogihaath/screens/activities_screen/edit_activity.dart';

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
              Navigator.pushNamed(context, EditActivity.id);
            },
            child: Text('Create Activites'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Activities_List.id);
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
