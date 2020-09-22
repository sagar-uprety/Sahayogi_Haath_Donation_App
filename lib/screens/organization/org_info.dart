
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/FlatButtonIcon.dart';
import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/theme.dart';
import '../../models/usermodel.dart';

import '../../provider/activity_provider.dart';

import '../../components/AppBars/appBar.dart';
import '../../components/AppBars/drawer.dart';
import './tabs/about.dart';
import './tabs/activities.dart';

class OrganizationInfo extends StatefulWidget {
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  @override
  Widget build(BuildContext context) {
    final OrganizationModel passedOrganization =
        ModalRoute.of(context).settings.arguments;

    return StreamProvider(
      create: (context) => ActivityProvider().getActivitiesbyOrg(passedOrganization.id),
          child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
            drawer: SideDrawer(),
            appBar: GlobalAppBar(
                bottom: TabBar(
                  isScrollable: true,
                  labelStyle: AppTheme.h5Style.bold,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: FlatButtonIcon(
                        text: 'About',
                        icon: null,
                        color: LightColor.purpleLight,
                      ),
                    ),
                    Tab(
                      child: FlatButtonIcon(
                        text: 'Donations',
                        icon: null,
                      ),
                    ),
                    Tab(
                      child: FlatButtonIcon(
                        text: 'Activities',
                        icon: null,
                      ),
                    ),
                  ],
                )),
            backgroundColor: Colors.white,
            body: TabBarView(
              children: [
                About(),
                TabActvities(),
                TabActvities(),
              ],
            ),
          ),),
    );
  }
}
