import 'package:flutter/material.dart';
import '../../../components/overview_detail.dart';
import '../../../constants.dart';
import '../../../theme/extention.dart';
// import '../../../theme/theme.dart';

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
          margin: EdgeInsets.only(top: size.height * 0.45),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images1/children.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Food Distribution",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "2020/02/09",
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    ),
                    // Text("Hello,",
                    //  style: TextStyles.title.subTitleColor),
                    // Text(user.name,
                    //  style: TextStyles.h1Style),
                    Container(
                      decoration: cGreyBoxDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.10)),
                            ),
                            child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    AssetImage("assets/images1/children.jpg"),
                                radius: size.width * 0.10),
                          ),
                        ],
                      ).p16,
                      //p16
                    ).vP8,
                    //vP4
                  ],
                ),
                //p16
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Nobody wants to stare at a blank wall all day long, which is why wall art is such a crucial step in the decorating process. And once you start brainstorming, the rest is easy. From gallery walls to DIY pieces like framing your accessories and large-scale photography, we've got plenty of wall art ideas to spark your creativity. And where better to look for inspiration that interior designer-decorated walls",
                  style: TextStyle(height: 1.6),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
