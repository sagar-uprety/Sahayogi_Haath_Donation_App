import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './services/firestore_service.dart';
import './provider/auth_provider.dart';
import './provider/activity_provider.dart';
import './theme/theme.dart';

import './routes.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';
<<<<<<< HEAD
import 'screens/dashboard/dashboard.dart';
=======
// import './screens/dashboard.dart';
// import './screens/dashboard_new.dart';
// import './screens/dashboard/dashboard_d_main.dart';
import './screens/organization/exploreorg.dart';
>>>>>>> exploreorg

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
              return ExploreOrganization();
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
