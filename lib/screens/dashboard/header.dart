import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/extras_model.dart';
import '../../provider/extras_provider.dart';
import '../../provider/user_provider.dart';

import '../../theme/theme.dart';
import '../../theme/extention.dart';
import '../../constants.dart';

import '../../components/overview_detail.dart';

class Header extends StatefulWidget {
  Header([this.userImage,this.passedOrganization]);
  final String userImage;
  final OrganizationDetail passedOrganization;
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  UserProvider user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    if (widget.userImage == null) {
      if (user.isDonor && widget.passedOrganization == null) return _donorOverview();
      if (user.isOrganization || widget.passedOrganization != null) return _organizationOverview();
      if (user.isAdmin) return _adminOverview();
    } else{
      return _organizationOverview();
    }
    return Container();
  }

  Widget _donorOverview() {
    final overview = Provider.of<ExtrasProvider>(context);
    return Container(
      decoration: cGreyBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          OverviewDetail(info: 'Rs. ${overview.amount}', title: 'Total Donation'),
          OverviewDetail(info: '${overview.count}', title: 'No. of Donations'),
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
    final overview = Provider.of<ExtrasProvider>(context);
    double amount = widget.passedOrganization != null ? widget.passedOrganization.receivedAmount : overview.amount;
    int count = widget.passedOrganization != null ? widget.passedOrganization.countDonation : overview.count;
    return Container(
      decoration: cGreyBoxDecoration,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OverviewDetail(info: 'Rs. $amount', title: 'Total Donation'),
            OverviewDetail(info: '$count', title: 'No. of Donations'),
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
    final overview = Provider.of<AdminExtraProvider>(context);

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
                        title: 'Total Donations', info: 'Rs. ${overview.amount}'),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OverviewDetail(
                                  title: 'Organizations', info: '${overview.countOrganization}'),
                              SizedBox(height: 5),
                              OverviewDetail(info: '${overview.countDonation}', title: 'Donations'),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OverviewDetail(
                                title: 'Donors',
                                info: '${overview.countDonor}',
                              ),
                              SizedBox(height: 5),
                              OverviewDetail(
                                  info: '${overview.countPendingVerification}', title: 'Pending \n Verifications')
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
