import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:sahayogihaath/provider_/activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/screens/activities_screen/activity_info.dart';
import 'package:sahayogihaath/screens/donate_screen/donate_main.dart';
import 'package:sahayogihaath/screens/donate_screen/donate_success.dart';
import 'package:sahayogihaath/services/firestore_service.dart';
import 'package:sahayogihaath/theme/theme.dart';
import 'package:flutter/services.dart';

import './provider_/auth_provider.dart';
=======
import 'package:provider/provider.dart';

import './routes.dart';
>>>>>>> dipesh-test
import './screens/welcome/welcome.dart';
import './screens/splash.dart';
<<<<<<< HEAD
import './screens/dashboard.dart';
import './screens/login/login_main.dart';
import './screens/explore.dart';
import '././screens/activities_screen/activity_info.dart';
import './screens/activities_screen/acitivity_list.dart';
import './screens/activities_screen/edit_activity.dart';
=======
import './screens/dashboard/dashboard_main.dart';
import './constants.dart';
import './provider/auth_provider.dart';
>>>>>>> dipesh-test

void main() {
  runApp(
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: SahayogiHaath(),
      ),
  );
}

class SahayogiHaath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //device orientation portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ActivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        StreamProvider(
          create: (context) => firestoreService.getActivities(),
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
              return DashboardMain();
            }
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            return Welcome();
          },
        ),
<<<<<<< HEAD
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
        },
      ),
=======
        routes: Routes.routes,
>>>>>>> dipesh-test
    );
  }
}
