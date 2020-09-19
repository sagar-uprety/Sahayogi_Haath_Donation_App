import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/extention.dart';
import '../../theme/text_styles.dart';

import '../../models/activitymodel.dart';
// import '../../components/TopAppBar.dart';
import '../../routes.dart';
import '../../components/ListTiles/ActivitiesListTiles.dart';
import '../../components/RoundedButton.dart';

class ActivitiesList extends StatefulWidget {
  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Color(0XFFfefefe),
        body: _activitiesList(),
      ),
    );
  }

  // appbar
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0XFFfefefe), //manage all theme color
      leading: BackButton(color: Theme.of(context).primaryColor),
      actions: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Image.asset(
              "assets/images1/janko.jpg", //user profile image
              fit: BoxFit.fill,
            ),
          ),
        ).p(9),
      ],
    );
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
