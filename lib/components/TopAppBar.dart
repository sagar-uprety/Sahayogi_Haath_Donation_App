import 'package:flutter/material.dart';
import '../theme/theme.dart';

class TopAppBar {
  static getAppBar() {
    return MaterialApp(
      child: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFFfefefe), //manage all theme color
        leading: BackButton(color: Theme.of(context).primaryColor),
        actions: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Image.asset(
                "assets/images1/janko.jpg", //user profile image
                fit: BoxFit.fill,
              ),
            ),
          ).p(9),
        ],
      ),
    );
  }
}
