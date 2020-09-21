
import 'package:flutter/cupertino.dart';
import 'screens/profile/user_profile.dart';
import 'screens/profile/edit_user_details.dart';

import './screens/admintransaction/admin_transaction.dart';
import './screens/donationDetail.dart';
import './screens/orgtransaction/organization.dart';
import 'screens/transaction/donationList.dart';
import './screens/login/login_main.dart';
import './screens/signup/signup_main.dart';
import './screens/signup/signup_org_main.dart';
import './screens/splash.dart';
import './screens/welcome/welcome.dart';
import './screens/dashboard/dashboard.dart';
import './screens/organization/exploreorg.dart';
import './screens/organization/org_info.dart';
import './screens/activities_screen/activity_info.dart';
import './screens/activities_screen/acitivity_list.dart';
import './screens/activities_screen/edit_activity.dart';
import './screens/donate_screen/donate_success.dart';
import './screens/donate_screen/donate_main.dart';
import './screens/donate_screen/donation_info.dart';
import './screens/organization/tabs/edit_organization.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String signupOrganization = '/signupOrganization';

  static const String dashboard = '/dashboard';
  static const String editData = '/editData';
  static const String profile = '/profile';

  static const String donate = "/donate_screen";
  static const String donate_success = "/donate_success";
  static const String donation_list = "/donation_list";
  static const String donation_info = "/donation_indo";

  static const String explore_org = "/explore_org";
  static const String org_info = "/org_info";
  static const String activities_list = "/activities_list";
  static const String activity_info = "/activity_info";
  static const String edit_activity = "/edit_activity";
  static const String edit_organization = "/edit_organization";

  static const String org_transaction = "/organization";
  static const String user_transaction = "/user_transaction";
  static const String admin_transaction = "/admin_transaction";
  static const String donation_detail = "/donationDetail";
 
  static final routes = <String, WidgetBuilder>{
    splash: (context) => SplashScreen(),
    welcome: (context) => Welcome(),
    login: (context) => LoginMain(),
    signup: (context) => SignUpMain(),
    signupOrganization: (context) => SignUpOrganizationMain(),
    dashboard: (context) => Dashboard(),
    explore_org: (context) => ExploreOrganization(),
    org_info: (context) => OrganizationInfo(),
    editData: (context) => EditData(),
    donate: (context) => DonateScreen(),
    donate_success: (context) => DonateSuccess(),
    donation_info: (context) => DonationInfo(),
    activities_list: (context) => ActivitiesList(),
    activity_info: (context) => ActivityInfo(),
    edit_activity: (context) => EditActivity(),
    profile: (context) => Profile(),
    edit_organization: (context) => EditOrganization(),
    org_transaction: (context) => OrganizationTransaction(),
    user_transaction: (context) => UserTransaction(),
    admin_transaction: (context) => AdminTransaction(),
    donation_detail: (context) => DonationDetail()
  };
}
