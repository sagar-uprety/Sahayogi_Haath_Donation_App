import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';

class Dashboard extends StatefulWidget {
  static const id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(65, 161, 36, 1),
      ),
      home: Scaffold(
          body: Column(
        children: [
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
      )),
    );
  }
}
