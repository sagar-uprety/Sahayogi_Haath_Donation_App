
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/dashboard/dashboard.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';


import './provider/user_provider.dart';
import 'provider/extras_provider.dart';
import './provider/usertransaction_provider.dart';
import './provider/auth_provider.dart';
import './provider/activity_provider.dart';

import './theme/theme.dart';
import './routes.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserTransactionProvider(),
        ),
        StreamProvider(
          create: (context) => UserTransactionProvider().getTransactions(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityProvider(),
        ),
        StreamProvider(
          create: (context) =>
              ActivityProvider().getActivities(),
        ),
        StreamProvider(
          create: (context) => UserProvider().getOrganizations()
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExtrasProvider(),
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
              // return BottomTabBar();
              // return OrganizationInfo();
              return Dashboard();
            }
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            return Welcome();
          },
        ),
        routes: Routes.routes,
      ),
    );
  }
}