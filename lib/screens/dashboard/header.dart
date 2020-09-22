import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/FireStoredata.dart';

import '../../provider/user_provider.dart';

import '../../theme/theme.dart';
import '../../theme/extention.dart';
import '../../constants.dart';

import '../../components/overview_detail.dart';

class Header extends StatefulWidget {
  Header([this.userImage]);
  final String userImage;
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  UserProvider user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    if (widget.userImage == null) {
      if (user.isDonor) return _donorOverview();
      if (user.isOrganization) return _organizationOverview();
      if (user.isAdmin) return _adminOverview();
    } else{
      return _organizationOverview();
    }
  }

  Widget _donorOverview() {
    return Container(
      decoration: cGreyBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          OverviewDetail(info: 'Rs. 1500.0', title: 'Total Donation'),
          OverviewDetail(info: '3', title: 'Organization'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xffffffff), width: 3, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(
                  Radius.circular(AppTheme.fullWidth(context) * 0.10)),
            ),
            child: CircleAvatar(
                backgroundImage: NetworkImage(widget.userImage == null
                    ? user.profileImage
                    : widget.userImage),
                radius: AppTheme.fullWidth(context) * .10),
          ),
        ],
      ).p16,
    ).vP4;
  }

  Widget _organizationOverview() {
    return Container(
      decoration: cGreyBoxDecoration,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OverviewDetail(info: 'Rs. 15000.0', title: 'Total Donation'),
            OverviewDetail(info: '11', title: 'Donors'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xffffffff),
                    width: 3,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                    Radius.circular(AppTheme.fullWidth(context) * 0.10)),
              ),
              child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(widget.userImage == null
                      ? user.profileImage
                      : widget.userImage),
                  radius: AppTheme.fullWidth(context) * .10),
            ),
          ]).p16,
    ).vP4;
  }

  Widget _adminOverview() {
    return Container(
      decoration: cGreyBoxDecoration,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverviewDetail(
                        title: 'Total Donations', info: 'Rs. 52500.0'),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OverviewDetail(
                                  title: 'Organizations', info: '30'),
                              SizedBox(height: 5),
                              OverviewDetail(info: 450, title: 'Donations'),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OverviewDetail(
                                title: 'Donors',
                                info: '5000',
                              ),
                              SizedBox(height: 5),
                              OverviewDetail(
                                  info: 5, title: 'Pending \n Verifications')
                            ])
                      ],
                    )
                  ]),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xffffffff),
                      width: 3,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppTheme.fullWidth(context) * 0.10)),
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(widget.userImage == null
                        ? user.profileImage
                        : widget.userImage),
                    radius: AppTheme.fullWidth(context) * .10),
              ),
            ),
          ]).p16,
    ).vP4;
  }
}
