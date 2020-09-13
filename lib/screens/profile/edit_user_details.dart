import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/RoundedButton.dart';

import '../../provider/user_provider.dart';
import './edit_data_field.dart';

import '../pickers/image_picker.dart';

import '../../theme/extention.dart';
import '../../theme/theme.dart';

class EditData extends StatefulWidget {
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();

  File _changedImage;

  void _pickedImage(File image) {
    _changedImage = image;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                Text(
                  'EDIT PROFILE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 15),
                ImageFilePicker(
                  _pickedImage,
                  imageType: ImageType.userProfile,
                  existingImage: user.profileImage,
                ),
                Column(children: [
                  EditDataField(
                    icon: Icons.person,
                    dataText: user.name,
                    onChanged: (value){
                      user.changeName(value.trim());
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                    onSaved: user.saveName,
                  ),
                  EditDataField(
                    icon: Icons.phone,
                    dataText: user.phone,
                    keyboardType: TextInputType.phone,
                    onChanged: (value){
                      user.changePhone(value.trim());
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length != 10) {
                        return 'This Phone Number is invalid';
                      }
                      return null;
                    },
                    onSaved: user.savePhone,
                  ),
                  EditDataField(
                    icon: Icons.location_on,
                    dataText: user.address,
                    onChanged: (value){
                      user.changeAddress(value.trim());
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Address cannot be empty';
                      }
                      return null;
                    },
                    onSaved: user.saveAddress,
                  ),
                  if(user.isOrganization)
                    EditDataField(
                      icon: Icons.access_time,
                      suffixIcon: Icons.today,
                      dataText: user.establishedDate,
                      type: 'date',
                      onChanged: (value){
                        user.changeEstablishedDate(value.trim());
                      },
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        }
                        return 'Invalid Date';
                      },
                      onSaved: user.saveEstablishmentDate,
                    ),
                  if(user.isOrganization)
                    EditDataField(
                      icon: Icons.category,
                      dataText: user.type,
                      type: 'type',
                      onChanged: (value){
                        user.changeType(value.trim());
                      },
                      onSaved: user.saveType,
                    ),
                  RoundButton(
                    text: 'Done',
                    onPress: (){
                      Navigator.pop(context);
                    }
                  )
                ])
              ]),
        ).ps(y: AppTheme.fullHeight(context) * 0.08),
      ),
    );
  }
}


