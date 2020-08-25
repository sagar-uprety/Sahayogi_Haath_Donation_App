import 'package:flutter/material.dart';
import 'package:sahayogihaath/models/organizationmodel.dart';
import 'package:provider/provider.dart';

class OrganizationInfo extends StatefulWidget {
  
  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  @override
  Widget build(BuildContext context) {
      final info = Provider.of<List<OrganizationModel>>(context);
    return Scaffold(
      body: (info != null)?
      ListView.builder(
        itemCount: info.length,
        itemBuilder: (context, index){
          return ListTile(
title: Text(info[index].name),
trailing: Text(info[index].description),
onTap: (){
  // do something if needed
},

          );
        }
        ): Center(child: CircularProgressIndicator()),

    );
  }
}
