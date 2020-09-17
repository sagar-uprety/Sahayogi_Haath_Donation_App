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

  List<OrganizationDetail> organizationdetail = [];
  List<OrganizationDetail> filterlist = [];

  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterList();
    });
  }

  filterList() {
    List<OrganizationDetail> _organizationdetail = [];
    _organizationdetail.addAll(organizationdetail);
    if (searchController.text.isEmpty) {
      _organizationdetail.retainWhere((organizationDetail) {
        String searchTerm = searchController.text.toLowerCase();
        String orgtitle = organizationDetail.title.toLowerCase();
        return orgtitle.contains(searchTerm);
      });
      setState(() {
        filterlist = _organizationdetail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
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
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  prefix: Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (value) {},
              ),
            ).vP8,

            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 24),
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Color(0xffEFEFEF),
            //       borderRadius: BorderRadius.circular(14)),
            //   child: Row(
            //     children: <Widget>[
            //       Icon(Icons.search),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Search",
            //         style: TextStyle(
            //           color: Colors.grey,
            //           fontSize: 19,
            //         ),
            //       )
            //     ],
            //   ),
            // ).vP8,

            Text("Categories", style: TextStyles.title.bold).vP8,

            Container(
              height: 30,
              child: ListView.builder(
                  itemCount: isSearching == true
                      ? filterlist.length
                      : categories.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategorieTile(
                      category: isSearching == true
                          ? filterlist[index]
                          : categories[index],
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
