
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/extras_provider.dart';
import '../../../provider/user_provider.dart';

import '../../../screens/dashboard/header.dart';
import '../../../screens/profile/edit_data_field.dart';

import '../../../constants.dart';
import '../../../theme/extention.dart';
import '../../../theme/theme.dart';
import '../../../theme/text_styles.dart';
import '../../../models/usermodel.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
    //   final OrganizationModel passedOrganization =
    //       ModalRoute.of(context).settings.arguments;
    // --
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
// --
    // Widget getBody(context) {
    //   final OrganizationModel passedOrganization =
    //       ModalRoute.of(context).settings.arguments;

    //   // final OrganizationDetail passedOrganizationdetail =
    //   //     ModalRoute.of(context).settings.arguments;

    //   TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    //   if (AppTheme.fullWidth(context) < 393) {
    //     titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    //   }

    //   var size = MediaQuery.of(context).size;
    //   return SingleChildScrollView(
    //       child: Stack(children: <Widget>[
    //     // Container(
    //     //   width: double.infinity,
    //     //   height: size.height * 0.5,
    //     //   decoration: BoxDecoration(
    //     //     image: DecorationImage(
    //     //         image: AssetImage("assets/images1/children.jpg"),
    //     //         fit: BoxFit.cover),
    //     //   ),
    //     // ),

    //     Container(
    //       height: AppTheme.fullHeight(context) * 0.42,
    //       child: Image.network(
    //         passedOrganization.profileImage,
    //         fit: BoxFit.fill,
    //       ),
    //     ),

    //     Container(
    //       margin: EdgeInsets.only(top: size.height * 0.45),
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //           color: Colors.white, borderRadius: BorderRadius.circular(46)),
    //       child: Padding(
    //         padding: const EdgeInsets.all(15),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Row(
    //               children: <Widget>[
    //                 SizedBox(
    //                   width: 5.0,
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text(
    //                       passedOrganization
    //                           .name, //name //avoid overflow problem
    //                       style: titleStyle,
    //                     ),
    //                     Text(
    //                       passedOrganization.establishedDate,
    //                       style: TextStyle(fontSize: 13),
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 5.0, right: 5.0),
    //                 ),
    //                 Container(
    //                   decoration: cGreyBoxDecoration,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     // --
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
                        // ++
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
    // ++
    //                   ).p16,
    //                 ).vP8,
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Text(
    //                   "zhgfydsgf",
    //                   // passedOrganization
    //                   //     .description, //name //avoid overflow problem
    //                   style: titleStyle,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ).vP16,
    //       ),
    //     )
    //   ]));
    // }
  }
}
