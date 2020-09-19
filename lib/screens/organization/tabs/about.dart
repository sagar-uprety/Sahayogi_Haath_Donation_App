import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../../../screens/dashboard/header.dart';
import '../../../screens/profile/edit_data_field.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/extention.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  // image: AssetImage("assets/images1/children.jpg"),
                  image: NetworkImage(user.profileImage),
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
                            user.name,
                            style: TextStyle(
                                height: 1.6,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.establishedDate,
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
                      Header(),
                      SizedBox(
                        height: 10,
                      ),
                      DescriptionSection(),
                      Text(
                        "Nobody wants to stare at a blank wall all day long, which is why wall art is such a crucial step in the decorating process. And once you start brainstorming, the rest is easy. From gallery walls to DIY pieces like framing your accessories and large-scale photography, we've got plenty of wall art ideas to spark your creativity. And where better to look for inspiration that interior designer-decorated walls",
                        style: TextStyle(
                          fontSize: FontSizes.bodySm,
                          fontWeight: FontWeight.w400,
                          height: 1.8,
                          letterSpacing: 0.4,
                        ),
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
}
