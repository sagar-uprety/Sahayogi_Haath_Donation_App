
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/theme/theme.dart';

import '../../theme/extention.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';

import '../../models/activitymodel.dart';
import '../../routes.dart';





String selectedCategorie= "Adults";

class ExploreOrganization extends StatefulWidget {
  @override
  _ExploreOrganizationState createState() => _ExploreOrganizationState();
}

class _ExploreOrganizationState extends State<ExploreOrganization> {

  List<String> categories = ["Adults","Childrens","Womens","Mens"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
      ),
      drawer: Drawer(
          child: Container()// Populate the Drawer in the next step.
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 5,),
              Text("Explore Organization", style: TextStyle(
                color: Colors.black87.withOpacity(0.8),
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),
              ).vP16,
              //  SizedBox(height: 40,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffEFEFEF),
                  borderRadius: BorderRadius.circular(14)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 10,),
                    Text("Search", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                    ),)
                  ],
                ),
              ).vP8,
              
              // SizedBox(height: 30,),
              Text("Categories", style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                  fontSize: 25,
                  fontWeight: FontWeight.w600
              ),
              ).vP16,
              // SizedBox(height: 20,),
              Container(
                height: 30,
                child: ListView.builder(
                itemCount: categories.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                  return CategorieTile(
                    categorie: categories[index],
                    isSelected: selectedCategorie == categories[index],
                    context: this,
                  );
                    }),
              ).vP8,
              // SizedBox(height: 20,),
            
              Text("Activities List", style: TextStyle(
                  color: Colors.black87.withOpacity(0.8),
                  fontSize: 25,
                  fontWeight: FontWeight.w600
              ),
              ).vP16,
              
             _activityTile(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _activityTile() {
    final activities = Provider.of<List<Activity>>(context);
    return (activities != null)
        ? Container(
            height:
                AppTheme.fullHeight(context) * 0.8, //check this. is it perfect?

            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          color: LightColor.grey.withOpacity(.2),
                        ),
                        BoxShadow(
                          offset: Offset(-3, 0),
                          blurRadius: 15,
                          color: LightColor.grey.withOpacity(.1),
                        )
                      ],
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      child: ListTile(
                        isThreeLine: true,
                        contentPadding: EdgeInsets.all(0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            height: 55,
                            width: 55,
                            //org image
                            child: Image.asset('assets/images1/ben.jpg',
                                fit: BoxFit.fill),
                          ),
                        ),
                        title: Text(
                          activities[index].title,
                          style: TextStyles.title.bold,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activities[index].description,
                              style: TextStyles.bodySm.subTitleColor.bold,
                            ),
                            Text(
                              "08/21/2020",
                              style: TextStyles.bodySm.subTitleColor,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ).ripple(
                      () {
                        Navigator.pushNamed(context, Routes.activity_info,
                            arguments: activities[index]);
                      },
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  );
                }),
          )
        : Center(child: CircularProgressIndicator());
  }

}

class CategorieTile extends StatefulWidget {

  final String categorie;
  final bool isSelected;
  _ExploreOrganizationState context;
  CategorieTile({this.categorie, this.isSelected,this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xffFFD0AA) : Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(widget.categorie, style: TextStyle(
          color: widget.isSelected ?  Color(0xffFC9535) : Color(0xffA1A1A1)
        ),
        ),
      ),
    );
  }
}

