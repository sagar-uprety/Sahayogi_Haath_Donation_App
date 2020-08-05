import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './dashboard.dart';

class DashboardMain extends StatefulWidget {
  static const id = 'dashboard';

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final user=await _auth.currentUser();

      if(user != null){
        loggedInUser=user;
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Sahayogi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
      ),
      body: Dashboard(),
    );
  }
}
