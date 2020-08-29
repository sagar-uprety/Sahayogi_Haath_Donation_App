import 'package:flutter/material.dart';
import '../tabs/Aboutus.dart';
import '../tabs/Activities.dart';
import '../tabs/photos.dart';

class OrganizationInfo extends StatefulWidget {
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tabbarpage(),
    );
  }
}

class Tabbarpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
          child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.grey,
      bottom: TabBar(
        indicatorColor: Colors.black,
        tabs: <Widget>[
          Tab(
            child: Text("About Us"),
          ),
           Tab(
            child: Text("Photos"),
          ),
           Tab(
            child: Text("Activities"),
          ),
           Tab(
            child: Text("About Us"),
          ),

        ],
        ),

        ),
          body: TabBarView(
    children: <Widget>[
      AboutUs(),
      PhotosSection(),
      ActivitiesScetion(),

    ],),

      ),
    );
  }
}