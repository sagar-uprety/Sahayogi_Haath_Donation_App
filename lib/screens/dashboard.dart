import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayogihaath/screens/donate_screen/donate_main.dart';
import '../screens/activities_screen/acitivity_list.dart';
import '../screens/activities_screen/activity_info.dart';
import '../screens/activities_screen/edit_activity.dart';

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
              Navigator.pushNamed(context, ActivitiesList.id);
            },
            child: Text('See Activites'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ActivityInfo.id);
            },
            child: Text('See Demo Activity Info'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, DonateScreen.id);
            },
            child: Text('Donate'),
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
