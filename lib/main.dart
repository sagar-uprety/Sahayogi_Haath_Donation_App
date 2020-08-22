import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayogihaath/components/transaction_components/Admin/data/cardDataattribute.dart';
import 'package:sahayogihaath/screens/transaction/admin_transaction.dart';
import 'package:sahayogihaath/screens/transaction/organization.dart';
import 'package:sahayogihaath/screens/transaction/user_transaction.dart';

import './screens/welcome/welcome.dart';
import './screens/signup/signup_main.dart';
import './screens/splash.dart';
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
          builder: (BuildContext ctx, AsyncSnapshot userSnapshot) {
            if (userSnapshot.hasData) {
              return OrganizationTransaction();
            }
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            return Welcome();
          },
        ),
        //home: UserTransaction(),
        routes: {
          Welcome.id: (ctx) => Welcome(),
          LoginMain.id: (ctx) => LoginMain(),
          SignUpMain.id: (ctx) => SignUpMain(),
          Dashboard.id: (ctx) => Dashboard(),
          Explore.id: (ctx) => Explore(),
          UserTransaction.id: (ctx) => UserTransaction(),
          AdminTransaction.id:(ctx)=>AdminTransaction(),
          OrganizationTransaction.id:(ctx) => OrganizationTransaction(),
        });
  }
}
