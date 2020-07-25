import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahayogihaath/screens/signup/signup.dart';
import 'screens/welcome/welcome.dart';
import './screens/dashboard.dart';
import './screens/login/login.dart';
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
        initialRoute: Welcome.id,
        routes: {
          Welcome.id: (ctx) => Welcome(),
          Login.id: (ctx) => Login(),
          SignUp.id: (ctx) => SignUp(),
          Dashboard.id: (ctx) => Dashboard(),
          Explore.id: (ctx) => Explore(),
        });
  }
}
