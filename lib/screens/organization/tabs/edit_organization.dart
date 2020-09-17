import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/models/organizationmodel.dart';
import 'package:sahayogihaath/provider/organization_provider.dart';
import 'package:sahayogihaath/screens/organization/org_info.dart';
import '../../pickers/image_picker.dart';
import 'dart:io';

class EditOrganization extends StatefulWidget {
  final OrganizationDetail organizationDetail;
  EditOrganization([this.organizationDetail]);
  @override
  _EditOrganizationState createState() => _EditOrganizationState();
}

class _EditOrganizationState extends State<EditOrganization> {
  final activityTitleController = TextEditingController();
  final activityDescriptionController = TextEditingController();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchKeyController = TextEditingController();

  String imageUrl;
  File _orgImage;

  void _pickedImage(File image) {
    _orgImage = image;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //New Record
    if (widget.organizationDetail == null) {
      titleController.text = "";
      descriptionController.text = "";
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<OrganizationProvider>(context, listen: false);
        productProvider.loadValues(OrganizationDetail());
      });
    } else {
      // Controller Update
      // titleController.text = widget.organizationDetail.title;
      // descriptionController.text = widget.organizationDetail.description;
      // imageUrl = widget.organizationDetail.image;
      // State Update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<OrganizationProvider>(context, listen: false);
        productProvider.loadValues(widget.organizationDetail);
      });
    }
    super.initState();
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
          TextField(
            decoration: InputDecoration(hintText: 'searchKey'),
            onChanged: (value) {
              organizationProvider.changeSearchKey(value);
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
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrganizationInfo()));
              }),
          RaisedButton(
              child: Text('Delete'),
              onPressed: () {
//  organizationProvider.removeOrgInfo();
              }),
        ],
      ),
    );
  }
}
