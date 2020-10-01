import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/extras_provider.dart';
import '../../provider/user_provider.dart';
import '../../provider/usertransaction_provider.dart';
import '../../provider/activity_provider.dart';

import '../../screens/organization/tabs/donations.dart';
import './tabs/about.dart';
import './tabs/activities.dart';

import '../../models/usermodel.dart';

import '../../theme/extention.dart';
import '../../theme/theme.dart';

import '../../components/AppBars/appBar.dart';
import '../../components/AppBars/drawer.dart';

class OrganizationInfo extends StatefulWidget {
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final OrganizationModel passedOrganization =
        ModalRoute.of(context).settings.arguments;
    final user = Provider.of<UserProvider>(context);
    final String _id =
        passedOrganization != null ? passedOrganization.id : user.id;
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => ActivityProvider().getActivitiesbyOrg(_id),
        ),
        StreamProvider(
          create: (context) => ExtrasProvider().getUserExtrabyId(_id),
        ),
        StreamProvider(
          create: (context) =>
              UserTransactionProvider().getTransactionsbyOrg(_id),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        initialIndex: index,
        child: Scaffold(
          drawer: SideDrawer(),
          appBar: GlobalAppBar(
            bottom: TabBar(
              isScrollable: true,
              indicator: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black, style: BorderStyle.solid))),
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (i) {
                setState(() {
                  index = i;
                });
              },
              labelStyle: AppTheme.h5Style.bold,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text('About'),
                ),
                Tab(
                  child: Text('Donations')
                ),
                Tab(
                  child: Text('Activities')
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            children: [
              About(),
              TabDonations(),
              TabActvities(),
            ],
          ),
        ),
      ),
    );
  }
}
