import 'package:flutter/material.dart';
import 'package:sahayogihaath/models/organizationmodel.dart';
import 'package:sahayogihaath/provider_/organization_provider.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/screens/organization_screen/org_info.dart';

class EditOrganization extends StatefulWidget {
   static const id = "editorganization";
  final OrganizationModel organizationModel;

  EditOrganization([this.organizationModel]);

  @override
  _EditOrganizationState createState() => _EditOrganizationState();
}

class _EditOrganizationState extends State<EditOrganization> {

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
void dispose(){
  nameController.dispose();
  descriptionController.dispose();
  super.dispose();
}
@override
void initState() { 
  if(widget.organizationModel== null){
//New Record
nameController.text = "";
descriptionController.text = "";
 new Future.delayed(Duration.zero, (){
    final organizationProvider = Provider.of<OrganizationProvider>(context, listen: false);
    organizationProvider.loadValues(OrganizationModel());
    });
  }
  else{
    //Controller Update
    nameController.text = widget.organizationModel.name;
    descriptionController.text = widget.organizationModel.description;
    //State update
    new Future.delayed(Duration.zero, (){
    final organizationProvider = Provider.of<OrganizationProvider>(context, listen: false);
    organizationProvider.loadValues(widget.organizationModel);
    });



  }
  super.initState();
  
}

  Widget build(BuildContext context) {
    final organizationProvider = Provider.of<OrganizationProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Organization name'),
              onChanged: (value){
organizationProvider.changeName(value);
              },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'About Organization'),
              onChanged: (value){
                organizationProvider.changeDescription(value);
              },
          ),
          //    RaisedButton(child: Text('Upload a image'),
          //  onPressed: (){
             
          //  }
          //  ),
          RaisedButton(child: Text('Submit'),
           onPressed: (){
             organizationProvider.saveInfo();
           }
           ),
          SizedBox(
            height: 20.0,
          ),
          (widget.organizationModel != null)?
          RaisedButton(
              color: Colors.red, child: Text('Delete'),
               onPressed: (){
                 organizationProvider.removeInfo(widget.organizationModel.infoId);
               }
               
               ): Container(),

                RaisedButton(child: Text('Organization Info'),
           onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrganizationInfo(),
        )
        );
           },
           ),
          SizedBox(
            height: 20.0,
          ),
        ]),
      ),
    );
  }


  // uploadImage(){
  //   //checkpermisiion

  //   //Select image
  // }
}
