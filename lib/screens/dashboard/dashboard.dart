import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../provider/auth_provider.dart';

import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';
import '../../routes.dart';

import '../../models/activitymodel.dart';
import '../../components/overview_detail.dart';
import '../../components/ActivitiesListTiles.dart';
import '../../components/DonationListTiles.dart';
import '../../components/FlatButtonIcon.dart';
import '../../constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserProvider user;
  bool isLoading = true;

  @override
  void initState() {
    getUserData().then((value) {
      print("SuccessFul");
    });

    super.initState();
  }

  getUserData() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: user.name == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _header(),
                      _category(),
                    ],
                  ),
                ),
                _generateLists(),
              ],
            ),
    );
  }

  //appbar
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: Icon(
        Icons.short_text,
        size: 30,
        color: Colors.black,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Logout'), //make something cool
          onPressed: () {
            AuthProvider().signOut();
          },
        )
      ],
    );
  }

  Widget _header() {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text(user.name, style: TextStyles.h1Style),
        Container(
          decoration: cGreyBoxDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OverviewDetail(info: 'Rs. 1500.0', title: 'Total Donation'),
              OverviewDetail(info: '3', title: 'Organization'),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xffffffff),
                      width: 3,
                      style: BorderStyle.solid),
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width * 0.10)),
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(user.profileImage),
                    radius: size.width * 0.10),
              ),
            ],
          ).p16,
        ).vP4,
      ],
    ).p16;
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 0, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category", style: TextStyles.title.bold),
              FlatButtonIcon(
                  text: 'Donate Now',
                  onPress: () {
                    Navigator.pushNamed(context, Routes.donate);
                  }),
                  
            ],
          ).vP4,
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .27,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCard("Orphanage", "350 +",
                  color: LightColor.green, lightColor: LightColor.lightGreen),
              _categoryCard("Elderly Care", "250+",
                  color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
              _categoryCard("Child Care", "500+",
                  color: LightColor.orange, lightColor: LightColor.lightOrange),
              _categoryCard("Women Welfare", "300+",
                  color: LightColor.green, lightColor: LightColor.lightGreen)
            ],
          ).hP4,
        ),
      ],
    );
  }

  Widget _categoryCard(String title, String subtitle,
      {Color color, Color lightColor, Function onPress}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        title,
                        style: titleStyle,
                        textAlign: TextAlign.center,
                      ).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {
          Navigator.pushNamed(context, Routes.explore_org); //test only
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget _generateLists() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Activities", style: TextStyles.title.bold).p(4),
              FlatButtonIcon(
                text: "View All",
                onPress: () {
                  Navigator.pushNamed(context, Routes.activities_list);
                },
              )
            ],
          ).hP16,
           
          _getOrgList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Recent Donations", style: TextStyles.title.bold).p(4),
              FlatButtonIcon(
                text: "View All",
                onPress: () {
                  Navigator.pushNamed(context, Routes.donation_list);
                },
              ),
            ],
          ).p16,
          _getTransactionList(),
         
        ],
      ),
    );
  }

  Widget _getOrgList() {
    final activities = Provider.of<List<Activity>>(context);
    return (activities != null)
        ? ActivitiesListTiles(
            listprovider: activities,
            itemCount: activities.length >= 5 ? 5 : 1,
            heightPercent: activities.length >= 5 ? 0.4 : 0.15,
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _getTransactionList() {
    final activities = Provider.of<List<Activity>>(context);
    return (activities != null)
        ? DonationListTiles(
            listprovider: activities,
            itemCount: activities.length >= 5 ? 5 : 1,
            heightPercent: activities.length >= 5 ? 0.4 : 0.15,
          )
        : Center(child: CircularProgressIndicator());
  }
}
