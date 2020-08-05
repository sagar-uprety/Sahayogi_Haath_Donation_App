import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              'Loading',
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
