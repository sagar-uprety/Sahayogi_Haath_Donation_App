import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/theme/theme.dart';

import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';

import '../../models/activitymodel.dart';
// import '../../components/TopAppBar.dart';
import '../../routes.dart';

class ActivitiesList extends StatefulWidget {
  @override
  _ActivitiesListState createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: TopAppBar.getAppBar(),
        backgroundColor: Color(0XFFfefefe),
        body: _activitiesList(),
      ),
    );
  }

  //appbar
  // Widget _appBar() {
  //   return AppBar(
  //     elevation: 0,
  //     backgroundColor: Color(0XFFfefefe), //manage all theme color
  //     leading: BackButton(color: Theme.of(context).primaryColor),
  //     actions: <Widget>[
  //       ClipRRect(
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(20),
  //         ),
  //         child: Container(
  //           height: 40,
  //           width: 40,
  //           decoration: BoxDecoration(
  //             color: Theme.of(context).backgroundColor,
  //           ),
  //           child: Image.asset(
  //             "assets/images1/janko.jpg", //user profile image
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //       ).p(9),
  //     ],
  //   );
  // }

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
        _activityTile(),
      ],
    );
  }

  Widget _activityTile() {
    final activities = Provider.of<List<Activity>>(context);
    return (activities != null)
        ? Container(
            height:
                AppTheme.fullHeight(context) * 0.8, //check this. is it perfect?
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          color: LightColor.grey.withOpacity(.2),
                        ),
                        BoxShadow(
                          offset: Offset(-3, 0),
                          blurRadius: 15,
                          color: LightColor.grey.withOpacity(.1),
                        )
                      ],
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: ListTile(
                        isThreeLine: true,
                        contentPadding: EdgeInsets.all(0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            height: 55,
                            width: 55,
                            //org image
                            child: Image.asset('assets/images1/ben.jpg',
                                fit: BoxFit.fill),
                          ),
                        ),
                        title: Text(
                          activities[index].title,
                          style: TextStyles.title.bold,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activities[index].description,
                              style: TextStyles.bodySm.subTitleColor.bold,
                            ),
                            Text(
                              "08/21/2020",
                              style: TextStyles.bodySm.subTitleColor,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ).ripple(
                      () {
                        Navigator.pushNamed(context, Routes.activity_info,
                            arguments: activities[index]);
                      },
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  );
                }),
          )
        : Center(child: CircularProgressIndicator());
  }
}
