
import 'package:flutter/cupertino.dart';
import 'package:sahayogihaath/screens/dashboard/dashboard_main.dart';
import 'package:sahayogihaath/screens/login/login_main.dart';
import 'package:sahayogihaath/screens/signup/signup_main.dart';
import 'package:sahayogihaath/screens/signup/signup_org_main.dart';
import 'package:sahayogihaath/screens/splash.dart';
import 'package:sahayogihaath/screens/welcome/welcome.dart';

class Routes{
  Routes._();

  static const String splash='/splash';
  static const String welcome='/welcome';
  static const String login='/login';
  static const String signup='/signup';
  static const String signupOrganization='/signupOrganization';
  static const String dashboard='/dashboard';

  static final routes = <String, WidgetBuilder> {
    splash: (context) => SplashScreen(),
    welcome: (context) => Welcome(),
    login: (context) => LoginMain(),
    signup: (context) => SignUpMain(),
    signupOrganization: (context) => SignUpOrganizationMain(),
    dashboard: (context) => DashboardMain(),
  };
}