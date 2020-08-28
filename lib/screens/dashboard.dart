import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayogihaath/screens/donate_screen/donate_main.dart';
import '../screens/activities_screen/acitivity_list.dart';
import '../screens/activities_screen/edit_activity.dart';
import '../routes.dart';

class Dashboard extends StatefulWidget {
  static const id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              Navigator.pushNamed(context, Routes.edit_activity);
            },
            child: Text('Create Activites'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.activities_list);
            },
            child: Text('See Activites'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.donate);
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
