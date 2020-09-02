import 'package:flutter/material.dart';
import '../../components/overview_detail.dart';
import '../../theme/extention.dart';
import '../../constants.dart';
import '../../components/RoundedButton.dart';

class OrganizationInfo extends StatefulWidget {
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Column(
      children: [
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
                        // backgroundImage: NetworkImage(user['profile_image']),
                        radius: size.width * 0.10),
                  ),
                ],
              ).p16,
            ).vP4,
            
            Container(
              width: double.infinity,
              height: 250.0,
              margin: EdgeInsets.only(
                  left: 14.0, top: 20.0, right: 12.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                // style: kMainTextStyle,
              ),
            ),

               Expanded(
                    flex: 5,
                    child: RoundButton(
                      radius: 10,
                      text: "Donate",
                      onPress: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                               
                      },
                    ),
                  ),
      ],
    );

  
  }
}