import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/FlatButtonIcon.dart';
import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/theme.dart';
import '../../models/usermodel.dart';

import '../../provider/activity_provider.dart';

import './tabs/about.dart';
import './tabs/activities.dart';
import './tabs/photos.dart';

class OrganizationInfo extends StatefulWidget {
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  @override
  Widget build(BuildContext context) {
    final OrganizationModel passedOrganization =
        ModalRoute.of(context).settings.arguments;
    StreamProvider(
        create: (context) => ActivityProvider().getActivitiesbyOrg(passedOrganization.id));

    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0.0,
              leading: BackButton(color: Colors.black),
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
                      text: 'Photos',
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
              Photos(),
              Photos(),
            ],
          ),
        ));
  }
}
