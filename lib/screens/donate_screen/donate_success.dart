import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/RoundedButton.dart';

import '../../routes.dart';

class DonateSuccess extends StatefulWidget {
  @override
  _DonateSuccessState createState() => _DonateSuccessState();
}

class _DonateSuccessState extends State<DonateSuccess> {
   
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ESewaResult response = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/heart.svg',
              color: Colors.blue,
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              height: size.height * 0.25,
              width: size.width * 0.85,
              child: Column(children: [
                Text(
                  "Your donation is successful",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "Thank You For Your Donation",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                Text(
                  response.totalAmount,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                Text(
                  response.referenceId,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ]),
            ),
            SizedBox(height: size.height * 0.08),
            RoundButton(
              text: 'Done',
              onPress: () async{
                Navigator.pushNamed(context, Routes.dashboard);
              },
            ),
          ],
        ),
      ),
    );
  }
}
