import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider_/auth_provider.dart';
import '../../theme/extention.dart';

class DonateScreen extends StatefulWidget {
  static const id = "donate_screen";
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  int donateAmount;
  DateTime date;
  String username;

  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
            // child: Text(username),
            ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
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
    );
  }
}
