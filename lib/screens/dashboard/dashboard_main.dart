import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider/auth_provider.dart';
import '../splash.dart';
import './dashboard.dart';

class DashboardMain extends StatefulWidget {
  static const id = 'dashboard';

  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  DocumentReference userInfo;

  Map<String,dynamic> user;

  bool isLoading=true;

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

        userInfo= Firestore.instance.collection('users').document(user.uid);

        getCurrentUserInfo();
      }
    }
    catch(e){
      print(e);
    }
  }

  void getCurrentUserInfo() async{
    try{
      await userInfo.get().then((doc){
        if(doc.exists){
          user=doc.data;
          
          setState(() {
            isLoading =false;
          });
          // print(doc.data);
        } else {
          print("No such document!");
        }
      }); 
    } catch(error){
      print('ERROR getting user details.'+ error);
    };
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
        actions: [
          FlatButton(
            onPressed: (){
              authProvider.signOut();
            },
            child: Text('Logout'),
          )
        ],
      ),
      body: isLoading ? SplashScreen() : Dashboard(user),
    );
  }
}
