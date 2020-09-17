
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/screens/dashboard/dashboard.dart';
import 'package:sahayogihaath/services/firestore_service.dart';

import './screens/organization/org_info.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';


import './provider/user_provider.dart';
import './provider/organization_provider.dart';
import './provider/usertransaction_provider.dart';
import './provider/auth_provider.dart';
import './provider/activity_provider.dart';

import './services/firestore_path.dart';
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
          // create: (context) => transactionService.getTransactions(),
          create: (context) => UserTransactionProvider().getTransactions(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityProvider(),
        ),
        StreamProvider(
          create: (context) =>
              FirestoreService().getDatas(path: FirestorePath.activities()),
        ),
        StreamProvider(
          create: (context) =>
              FirestoreService().getdocsData(path: FirestorePath.organizations()),
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