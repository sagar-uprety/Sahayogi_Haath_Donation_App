import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../provider/activity_provider.dart';

import '../../screens/activities_screen/edit_activity.dart';

import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

import '../../components/RoundedButton.dart';
import '../../models/activitymodel.dart';

class ActivityInfo extends StatefulWidget {
  @override
  _ActivityInfoState createState() => _ActivityInfoState();
}

class _ActivityInfoState extends State<ActivityInfo> {
  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final activityProvider = Provider.of<ActivityProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final Activity passedActivity = ModalRoute.of(context).settings.arguments;

    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: AppTheme.fullHeight(context) * 0.42,
              child: Image.network(
                passedActivity.image,
                fit: BoxFit.cover,
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                passedActivity
                                    .title, //name //avoid overflow problem
                                style: titleStyle,
                              ),
                              IconButton(
                                  icon: Icon(
                                    // model.isfavourite ? Icons.favorite : Icons.favorite_border, //ambigious
                                    Icons.favorite,
                                    // color: model.isfavourite ? Colors.red : LightColor.grey,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // setState(() {
                                    //   model.isfavourite = !model.isfavourite;
                                    // });
                                  })
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                passedActivity.authorName,
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                              Text(
                                "Published On: " +
                                    DateFormat('dd MMM yyyy H:m')
                                        .format(passedActivity.time.toDate()),
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text(
                          passedActivity.description,
                          textAlign: TextAlign.justify,
                          style: TextStyles.body,
                          maxLines: 100,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            user.isAdmin || user.id == passedActivity.authorid
                ? Positioned(
                    bottom: 10,
                    left: AppTheme.fullWidth(context) * .05,
                    right: AppTheme.fullWidth(context) * .05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: RoundButton(
                            radius: 10,
                            text: "Edit",
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditActivity(passedActivity)));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 45,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: LightColor.grey.withAlpha(200),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red[400],
                            ),
                          ),
                        ).ripple(
                          () {
                            activityProvider
                                .removeActivity(passedActivity.activityID);
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ],
                    ).vP16,
                  )
                : Container(),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
