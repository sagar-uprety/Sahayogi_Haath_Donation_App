import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/screens/activities_screen/acitivity_list.dart';
import 'package:sahayogihaath/screens/dashboard/dashboard.dart';
import 'package:sahayogihaath/screens/organization/exploreorg.dart';
import 'package:sahayogihaath/screens/organization/tabs/activities.dart';
// import 'package:sahayogihaath/screens/organization/exploreorg.dart';
// import 'package:sahayogihaath/screens/organization/org_info.dart';
// import 'package:sahayogihaath/screens/organization/tabs/about.dart';
// import './screens/organization/org_info.dart';

// import './screens/dashboard/dashboard.dart';
import './screens/welcome/welcome.dart';
import './screens/splash.dart';
// import './screens/organization/tabs/edit_organization.dart';
// import './screens/organization/exploreorg.dart';
// import './screens/activities_screen/acitivity_list.dart';
import './screens/activities_screen/edit_activity.dart';

import './provider/user_provider.dart';
import './provider/organization_provider.dart';
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
          create: (context) => ActivityProvider().getActivities(),
        ),

        StreamProvider(
          create: (context) => UserProvider().getOrganizations(),
        ),

        // StreamProvider(
        //   create: (context) => ActivityProvider().getUserId(),
        // ),

        // StreamProvider(
        //   create: (context) =>
        //       FirestoreService().getdocsData(path: FirestorePath.organizations()),
        // ),
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
              // return ActivitiesList();
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
