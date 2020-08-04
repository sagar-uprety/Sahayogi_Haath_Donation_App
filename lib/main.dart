import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/welcome/welcome.dart';
import './screens/signup/signup_main.dart';
import './screens/dashboard.dart';
import './screens/login/login_main.dart';
import './screens/explore.dart';
import './constants.dart';

void main() {
  runApp(SahayogiHaath());
}

class SahayogiHaath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
        title: 'Sahayogi Haath',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: Color(0xFFf1f3f6),
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.sarabunTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.lobster(
              textStyle: textTheme.bodyText1,
            ),
            // TODO:set app-wide text theme
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (BuildContext context, AsyncSnapshot userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              // return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return Dashboard();
            }
            return Welcome();
          },
        ),
        routes: {
          Welcome.id: (ctx) => Welcome(),
          LoginMain.id: (ctx) => LoginMain(),
          SignUpMain.id: (ctx) => SignUpMain(),
          Dashboard.id: (ctx) => Dashboard(),
          Explore.id: (ctx) => Explore(),
        });
  }
}
