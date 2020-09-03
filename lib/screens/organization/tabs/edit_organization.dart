import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider/organization_provider.dart';
import 'package:sahayogihaath/screens/organization/org_info.dart';
import '../../pickers/image_picker.dart';
import 'dart:io';

class EditOrganization extends StatefulWidget {
  @override
  _EditOrganizationState createState() => _EditOrganizationState();
}

class _EditOrganizationState extends State<EditOrganization> {
  String imageUrl;
  File _orgImage;

  void _pickedImage(File image) {
    _orgImage = image;
  }

  @override
  Widget build(BuildContext context) {
    final organizationProvider = Provider.of<OrganizationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Edit organization')),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'title'),
            onChanged: (value) {
              organizationProvider.changeTitle(value);
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'description'),
            onChanged: (value) {
              organizationProvider.changeDescription(value);
            },
          ),
          ImageFilePicker(
            _pickedImage,
            imageType: ImageType.organization,
            existingImage: imageUrl,
          ),
          RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                organizationProvider.saveOrganizationInfo();
                FocusScope.of(context).unfocus();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => OrganizationInfo()));
              }),
          RaisedButton(
              child: Text('Delete'),
              onPressed: () {
// organizationProvider.removeOrgActivity();
              }),
        ],
      ),
    );
  }
}
