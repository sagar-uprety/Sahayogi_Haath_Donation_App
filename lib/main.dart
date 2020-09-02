import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:sahayogihaath/screens/organization/DetailScreen.dart';
import 'package:sahayogihaath/screens/organization/GalleryScreen.dart';
import 'package:sahayogihaath/screens/organization/organizationinfo.dart';
=======
import 'package:sahayogihaath/screens/dashboard/dashboard.dart';
>>>>>>> sagar

import './provider/user_provider.dart';
import './services/firestore_path.dart';

import './services/firestore_service.dart';
import './provider/auth_provider.dart';
import './provider/activity_provider.dart';
import './theme/theme.dart';

import './routes.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';
<<<<<<< HEAD
=======
import './screens/organization/org_info.dart';
import './components/AppBars/BottomTabBar.dart';
>>>>>>> sagar

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
          create: (context) =>
              firestoreService.getDatas(path: FirestorePath.activities()),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
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
<<<<<<< HEAD
              return OrganizationInfo();
=======
              // return BottomTabBar();
              return Dashboard();
>>>>>>> sagar
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
