import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../theme/extention.dart';
import '../../../theme/theme.dart';
import '../../../components/overview_detail.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }
}

Widget getBody(context) {
  var size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images1/children.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * 0.45),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(46)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Food Distribution",
                          style: TextStyle(
                              height: 1.6,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "2020/02/09",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    ),
                    Container(
                      decoration: cGreyBoxDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          OverviewDetail(
                              info: 'Rs. 1500.0', title: 'Total Donation'),
                          OverviewDetail(info: '3', title: 'Organization'),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffffffff),
                                  width: 3,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  AppTheme.fullWidth(context) * 0.10)),
                            ),
                            child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    AssetImage("assets/images1/children.jpg"),
                                radius: AppTheme.fullWidth(context) * .10),
                          ),
                        ],
                      ).p16,
                    ).vP8,
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Nobody wants to stare at a blank wall all day long, which is why wall art is such a crucial step in the decorating process. And once you start brainstorming, the rest is easy. From gallery walls to DIY pieces like framing your accessories and large-scale photography, we've got plenty of wall art ideas to spark your creativity. And where better to look for inspiration that interior designer-decorated walls",
                      style: TextStyle(
                        height: 1.8,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ).vP16,
          ),
        ),
      ],
    ),
  );
}
