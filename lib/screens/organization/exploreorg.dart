import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/models/organizationmodel.dart';

import '../../theme/extention.dart';
import '../../theme/text_styles.dart';

import '../../components/caterogy_tile_single.dart';
import '../../components/ListTiles/OrgListTiles.dart';


String selectedCategory = "Orphanage";

class ExploreOrganization extends StatefulWidget {
  @override
  _ExploreOrganizationState createState() => _ExploreOrganizationState();
}

class _ExploreOrganizationState extends State<ExploreOrganization> {
  List<String> categories = [
    "Orphanage",
    "Child Care",
    "Nusring Home",
    "Edlerly Care"
  ];

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
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategorieTile(
                      category: categories[index],
                      isSelected: selectedCategory == categories[index],
                      context: this,
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
    final organinfo = Provider.of<List<OrganizationDetail>>(context);
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
