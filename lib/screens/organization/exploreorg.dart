import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usermodel.dart';
import '../signup/signup_org.dart';

import '../../theme/extention.dart';
import '../../theme/text_styles.dart';

import '../../components/category_tile_single.dart';
import '../../components/ListTiles/OrgListTiles.dart';



class ExploreOrganization extends StatefulWidget {
  @override
  _ExploreOrganizationState createState() => _ExploreOrganizationState();
}

class _ExploreOrganizationState extends State<ExploreOrganization> {
  String selectedCategory = organizationType[0];

  changeSelectedCategory(String value){
    setState(() {
      selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          leading: BackButton(color: Colors.black)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Explore Organization",
              style: TextStyles.titleM.bold,
            ).vP8,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
            ).vP8,
            Text("Categories", style: TextStyles.title.bold).vP8,
            Container(
              height: 30,
              child: ListView.builder(
                  itemCount: organizationType.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      category: organizationType[index],
                      isSelected: selectedCategory == organizationType[index],
                      context: this,
                      changeCategory: changeSelectedCategory
                    );
                  }),
            ).vP8,
            _getOrgList(),
          ],
        ).hP16,
      ),
    );
  }

  Widget _getOrgList() {
    final organinfo = Provider.of<List<OrganizationModel>>(context);
    return (organinfo != null)
        ? OrgListTiles(
            listprovider: organinfo,
            itemCount: organinfo.length,
            heightPercent: 0.7,
            hm: 0,
          )
        : Center(child: CircularProgressIndicator());
  }
}
