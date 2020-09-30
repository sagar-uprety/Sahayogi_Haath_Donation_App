import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/timeline.dart';

import '../../provider/user_provider.dart';

import '../../constants.dart';
import '../../theme/theme.dart';
import '../../theme/extention.dart';
import '../../routes.dart';

class DonationListTiles extends StatefulWidget {
  final List listprovider;
  final int itemCount;
  final double heightPercent;
  DonationListTiles({
    this.listprovider,
    this.itemCount,
    this.heightPercent,
  });
  @override
  _DonationListTilesState createState() => _DonationListTilesState();
}

class _DonationListTilesState extends State<DonationListTiles> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double height = queryData.size.height * 0.007;
    double cardWidth = MediaQuery.of(context).size.width * 0.9;
    double width = cardWidth * 0.035;
    return Container(
      height: AppTheme.fullHeight(context) *
          widget.heightPercent, //check this. is it perfect?
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            DateTime date = widget.listprovider[index].time.toDate();
            String time = DateFormat('dd MMM yyyy').format(date);
            double donatedamount = widget.listprovider[index].amount;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Timeline.setDate(date),
                  style: kTransactionCardBoxText,
                ),
                SizedBox(
                  height: queryData.size.height * 0.007,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: kHomeDecoration,
                  padding: EdgeInsets.all(width),
                  child: Container(
                    width: cardWidth * 1,
                    child: Row(children: <Widget>[
                      FittedBox(
                        child: Container(
                          width: cardWidth * 0.12,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget.listprovider[index].donorImage),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth * 0.03,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: cardWidth * 0.45,
                        child: FittedBox(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  FittedBox(
                                    child: Text('to:',
                                        style: kTransactionCardBoxText),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  FittedBox(
                                    child: Text(
                                        widget.listprovider[index].donee,
                                        style: kTransactionCardDoneeBoxText),
                                  ),
                                ]),
                                FittedBox(
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    direction: Axis.vertical,
                                    children: [
                                      Text(widget.listprovider[index].donor,
                                          style: kDetailTransactionCardText),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Text('$time',
                                          style: kDetailTransactionCardText),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: cardWidth * 0.05,
                      ),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        width: cardWidth * 0.3,
                        child: FittedBox(
                          child: Row(
                            children: [
                              FittedBox(
                                child: Text(
                                  'Rs $donatedamount',
                                  style: kAmount,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ).ripple(
              () {
                final user = Provider.of<UserProvider>(context,listen: false);
                if (user.isOrganization || user.isAdmin || widget.listprovider[index].donorId == user.id)
                  Navigator.pushNamed(context, Routes.donation_detail,
                      arguments: widget.listprovider[index]);
              },
            );
          }),
    ).ps(x: 10);
  }
}
