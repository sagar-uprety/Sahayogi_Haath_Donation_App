import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider/user_provider.dart';

import '../../theme/extention.dart';
import '../../theme/text_styles.dart';

import '../../models/activitymodel.dart';
// import '../../components/TopAppBar.dart';
import '../../routes.dart';
import '../../components/ListTiles/ActivitiesListTiles.dart';
import '../../components/RoundedButton.dart';
import '../../components/AppBars/appBar.dart';

class ActivitiesList extends StatefulWidget {
  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GlobalAppBar(),
        backgroundColor: Color(0XFFfefefe),
        body: _activitiesList(),
      ),
    );
  }

  Widget _activitiesList() {
    final user = Provider.of<UserProvider>(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Recent Activities", style: TextStyles.title.bold),
            IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {})
                .p(15)
          ],
        ).hP16,
        _activityTile().vP8,
        if (user.isOrganization)
          RoundButton(
            text: "Publish Activity",
            onPress: () {
              Navigator.pushReplacementNamed(context, Routes.edit_activity);
            },
          ),
      ],
    );
  }

  Widget _activityTile() {
    final activities = Provider.of<List<Activity>>(context);
    return (activities != null)
        ? ActivitiesListTiles(
            listprovider: activities,
            itemCount: activities.length,
            heightPercent: 0.7, //from 0 to 1
          )
        : Center(child: CircularProgressIndicator());
  }
}
