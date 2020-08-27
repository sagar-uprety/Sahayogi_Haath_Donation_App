import 'package:flutter/cupertino.dart';

import 'screens/dashboard/dashboard_d_main.dart';
import './screens/edit_user_details.dart';
import './screens/login/login_main.dart';
import './screens/signup/signup_main.dart';
import './screens/signup/signup_org_main.dart';
import './screens/splash.dart';
import './screens/welcome/welcome.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String signupOrganization = '/signupOrganization';
  static const String dashboard = '/dashboard';
  static const String editData = '/editData';

  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    welcome: (context) => Welcome(),
    login: (context) => LoginMain(),
    signup: (context) => SignUpMain(),
    signupOrganization: (context) => SignUpOrganizationMain(),
    dashboard: (context) => DashboardMain(),
    editData: (context) => EditData(),
  };
}
