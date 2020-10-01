import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/dashboard/dashboard.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';
<<<<<<< HEAD

=======
>>>>>>> 0c646e4e227d3afdcd9b134477b3c0014cd83276
import './provider/user_provider.dart';
import 'provider/extras_provider.dart';
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
          create: (context) => ActivityProvider().getActivities(),
        ),
        StreamProvider(
<<<<<<< HEAD
          create: (context) => FirestoreService()
              .getdocsData(path: FirestorePath.organizations()),
=======
          create: (context) => UserProvider().getOrganizations(),
>>>>>>> 0c646e4e227d3afdcd9b134477b3c0014cd83276
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExtrasProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminExtraProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Sahayogi Haath',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (BuildContext ctx, AsyncSnapshot userSnapshot) {
            final admin = Provider.of<AdminExtraProvider>(ctx,listen: false);
            admin.getAdminInfo().then((value) {print('Admin Data Received');});
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
