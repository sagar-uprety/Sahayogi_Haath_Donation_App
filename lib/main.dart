import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/screens/activities_screen/activity_info.dart';
import 'package:sahayogihaath/screens/donate_screen/donate_main.dart';
import 'package:sahayogihaath/screens/donate_screen/donate_success.dart';
import 'package:sahayogihaath/screens/organization_screen/org_form.dart';
import 'package:sahayogihaath/services/org_firestore_service.dart';
import 'services/org_firestore_service.dart';
import 'package:sahayogihaath/theme/theme.dart';
import 'package:flutter/services.dart';

import './provider_/auth_provider.dart';
import './screens/welcome/welcome.dart';
import './screens/signup/signup_main.dart';
import './screens/splash.dart';
import './screens/dashboard.dart';
import './screens/login/login_main.dart';
import './screens/explore.dart';
import '././screens/activities_screen/activity_info.dart';
import './screens/activities_screen/acitivity_list.dart';
import './screens/activities_screen/edit_activity.dart';
import './provider_/organization_provider.dart';
import './services/org_firestore_service.dart';
import './screens/organization_screen/org_form.dart';

void main() {
  runApp(SahayogiHaath());
}

class SahayogiHaath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //device orientation portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final firestoreService = OrgFirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // create: (context) => ActivityProvider(),
          create: (context) => OrganizationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        StreamProvider(
          create: (context) => firestoreService.getInfo(),
        ),
      ],
      child: MaterialApp(
        title: 'Sahayogi Haath',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
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
          ActivitiesList.id: (ctx) => ActivitiesList(),
          EditActivity.id: (ctx) => EditActivity(),
          DonateScreen.id: (ctx) => DonateScreen(),
          DonateSuccess.id: (ctx) => DonateSuccess(),
          EditOrganization.id: (ctx) => EditOrganization(),
        },
      ),
    );
  }
}
