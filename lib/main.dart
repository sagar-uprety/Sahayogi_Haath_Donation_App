import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahayogihaath/provider_/activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/screens/activities_screen/activity_info.dart';
import 'package:sahayogihaath/services/firestore_service.dart';

import './screens/welcome/welcome.dart';
import './screens/signup/signup_main.dart';
import './screens/splash.dart';
import './screens/dashboard.dart';
import './screens/login/login_main.dart';
import './screens/explore.dart';
import '././screens/activities_screen/activity_info.dart';
import './screens/activities_screen/acitivity_list.dart';
import './screens/activities_screen/edit_activity.dart';
import './constants.dart';

void main() {
  runApp(SahayogiHaath());
}

class SahayogiHaath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ActivityProvider(),
        ),
        StreamProvider(
          create: (context) => firestoreService.getActivities(),
        ),
      ],
      child: MaterialApp(
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
              return Dashboard();
            }
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
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
          ActivityInfo.id: (ctx) => ActivityInfo(),
          Activities_List.id: (ctx) => Activities_List(),
          EditActivity.id: (ctx) => EditActivity(),
        },
      ),
    );
  }
}
