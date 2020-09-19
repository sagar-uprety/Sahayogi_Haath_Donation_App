
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/extras_provider.dart';
import '../../../provider/user_provider.dart';

import '../../../screens/dashboard/header.dart';
import '../../../screens/profile/edit_data_field.dart';

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
    final extra = Provider.of<ExtrasProvider>(context);
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: extra.banner != null ? NetworkImage(extra.banner) : AssetImage('assets/images/def_banner.jpg'),
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
