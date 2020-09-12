import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider/organization_provider.dart';
import 'package:sahayogihaath/screens/organization/tabs/edit_organization.dart';
import './provider/user_provider.dart';
import './services/firestore_path.dart';

import './services/firestore_service.dart';
import './provider/auth_provider.dart';
import './provider/activity_provider.dart';
import './theme/theme.dart';

import './routes.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';

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
        StreamProvider(
          create: (context) =>
              firestoreService.getdocsData(path: FirestorePath.organizations()),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrganizationProvider(),
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
              return EditOrganization();
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
