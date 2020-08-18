import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../provider/auth_provider.dart';
import '../../components/activity_list_container.dart';
import '../../components/donation_list_container.dart';
import '../../components/overview_detail.dart';
import '../../constants.dart';

class Dashboard extends StatelessWidget {
  Dashboard(this.user);

  final user;
    
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final authProvider = Provider.of<AuthProvider>(context);
    
    print(user);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.046),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              'Welcome ${user['name']}',
              style: tTitleTextStyle.copyWith(fontSize: size.width*0.065),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Donation Overview',
              style: tTitleTextStyle.copyWith(fontSize: size.width*0.035),
            ),
            SizedBox(
              height: size.height*0.012,
            ),
            Container(
              decoration: cGreyBoxDecoration,
              padding: EdgeInsets.symmetric(horizontal: size.width*0.035, vertical: size.height*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OverviewDetail(info: 'Rs. 1500.0', title: 'Total Donation'),
                  OverviewDetail(info: '3', title: 'Organization'),
                  Padding(
                    padding: EdgeInsets.only(right: size.width*0.028),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffffffff), width: 4, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(size.width*0.116)),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(user['profile_image']),
                        radius: size.width*0.093
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width*0.018,
            ),
            Text(
              'Recent Donations',
              style: tTitleTextStyle.copyWith(fontSize: size.width*0.04),
            ),
            SizedBox(
              height: size.width*0.012,
            ),
            DonationContainer(),
            FlatButton(
              onPressed: (){
                print('See All Donations');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'See All Donations',
                    style: tSeeMoreTextStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.open_in_new,
                    color: Color(0xff999999),
                    size: 14,
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width*0.018,
            ),
            Text(
              'Recent Activities',
              style: tTitleTextStyle.copyWith(fontSize: size.width*0.04),
            ),
            SizedBox(
              height: size.width*0.012,
            ),
            ActivityContainer(),
            FlatButton(
              onPressed: (){
                print('See All Donations');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'See All Donations',
                    style: tSeeMoreTextStyle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.open_in_new,
                    color: Color(0xff999999),
                    size: 14,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}