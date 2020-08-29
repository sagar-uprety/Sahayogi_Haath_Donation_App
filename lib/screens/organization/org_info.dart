import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  static const id = "activity_info";
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
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
    // final activityProvider = Provider.of<ActivityProvider>(context);
    // final Activity passedActivity = ModalRoute.of(context).settings.arguments;

    // TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    // if (AppTheme.fullWidth(context) < 393) {
    //   titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    // }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              height: AppTheme.fullHeight(context) * 0.42,
              child: Image.network(
                'https://images.unsplash.com/photo-1527788263495-3518a5c1c42d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1983&q=80',
                fit: BoxFit.fill,
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 1,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  // height: AppTheme.fullHeight(context) * 0.5,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 15), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          indicatorColor: Colors.black,
                          tabs: <Widget>[
                            Tab(child: Text("About")),
                            Tab(child: Text("Photos")),
                            Tab(child: Text("Activities")),
                          ],
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          controller: scrollController,
                          child: Container(
                            height: AppTheme.fullHeight(context) * 0.5,
                            child: TabBarView(
                                children: [About(), TabActvities(), Photos()]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar()
          ],
        ),
      ),
    );
  }
}
