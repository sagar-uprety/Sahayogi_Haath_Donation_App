import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/components/FlatButtonIcon.dart';
import 'package:sahayogihaath/provider/activity_provider.dart';
import 'package:sahayogihaath/screens/activities_screen/edit_activity.dart';
import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

import '../../components/RoundedButton.dart';
import '../../models/activitymodel.dart';
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
