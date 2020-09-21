import 'package:flutter/material.dart';
import 'package:sahayogihaath/FireStoredata.dart';
import 'package:sahayogihaath/models/usermodel.dart';
import 'package:sahayogihaath/provider/activity_provider.dart';
import '../../../theme/extention.dart';
import 'package:provider/provider.dart';
import '../../../theme/text_styles.dart';
import '../../../components/ListTiles/ActivitiesListTiles.dart';
import '../../../models/activitymodel.dart';

class TabActvities extends StatefulWidget {
  @override
  _TabActvitiesState createState() => _TabActvitiesState();
}

class _TabActvitiesState extends State<TabActvities> {
  @override
  Widget build(BuildContext context) {
    return _activitiesList();
  }

  Widget _activitiesList() {
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

