import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/RoundedInput.dart';
import '../constants.dart';

import '../provider/activity_provider.dart';
import '../provider/user_provider.dart';

import '../screens/pickers/image_picker.dart';
import '../screens/signup/signup_org.dart';

import '../theme/text_styles.dart';
import '../theme/extention.dart';
import '../theme/theme.dart';

class EditData extends StatefulWidget {
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();

  File _changedImage;
  bool isSaving=false;

  bool obscureText = false;

  void _pickedImage(File image) {
    _changedImage = image;
  }

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
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
                      user.changeName(value);
                    },
                  ),
                  // EditDataField(
                  //   icon: Icons.email,
                  //   dataText: user.email,
                  //   onChanged: (value){
                  //     user.changeEmail(value);
                  //   }
                  // ),
                  // EditDataField(
                  //   icon: Icons.lock,
                  //   dataText: '********',
                  //   obscureText: obscureText,
                  //   suffixIcon:
                  //       obscureText ? Icons.visibility_off : Icons.visibility,
                  //   onClickedSuffixIcon: toggleVisibility,
                  //   onChanged: (value){
                  //     user.changePassword(value);
                  //     print(value);
                  //   },
                  // ),
                  EditDataField(
                    icon: Icons.phone,
                    dataText: user.phone,
                    keyboardType: TextInputType.phone,
                    onChanged: (value){
                      user.changePhone(value);
                    },
                  ),
                  EditDataField(
                    icon: Icons.location_on,
                    dataText: user.address,
                    onChanged: (value){
                      user.changeAddress(value);
                    },
                  ),
                  if(user.isOrganization)
                    EditDataField(
                      icon: Icons.access_time,
                      suffixIcon: Icons.today,
                      dataText: user.establishedDate,
                      type: 'date',
                      onChanged: (value){
                        user.changeEstablishedDate(value);
                      },
                    ),
                  if(user.isOrganization)
                    EditDataField(
                      icon: Icons.category,
                      dataText: user.type,
                      type: 'type',
                      onChanged: (value){
                        user.changeType(value);
                      },
                    ),
                  user.saveState == SaveState.Saving ?
                      Center(child: CircularProgressIndicator()) :
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        buttonHeight: AppTheme.fullHeight(context) * 0.05,
                        buttonPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        children: [
                          Container(
                            width: AppTheme.fullWidth(context) *0.4,
                            child: RaisedButton(
                              color: kPrimaryColor,
                              textColor: Colors.white,
                              onPressed: ()async{
                                await user.updateProfile();
                                if(user.saveState == SaveState.Saved)
                                  Navigator.pop(context);
                              },
                              child: Text(
                                'Save',
                              ),
                            ),
                          ),
                          Container(
                            width: AppTheme.fullWidth(context) *0.4,
                            child: OutlineButton(
                              color: kPrimaryColor,
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                              ),
                            ),
                          ),
                        ],
                      )
                ])
              ]),
        ).ps(y: AppTheme.fullHeight(context) * 0.08),
      ),
    );
  }
}

class EditDataField extends StatefulWidget {
  final IconData icon, suffixIcon;
  final String dataText;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String) onChanged;
  final Function onClickedSuffixIcon;
  final FormFieldValidator<String> validator;
  final String type;

  EditDataField(
      {@required this.icon,
      @required this.dataText,
      this.keyboardType = TextInputType.name,
      this.suffixIcon,
      this.onChanged,
      this.obscureText = false,
      this.onClickedSuffixIcon,
      this.validator,
      this.type = 'normal'});

  @override
  _EditDataFieldState createState() => _EditDataFieldState();
}

class _EditDataFieldState extends State<EditDataField> {
  bool _isEditable = false;

  void toggleEditability() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isEditable ? _editingData() : _currentData(),
    );
  }

  Widget _currentData() {
    return Row(
      children: [
        Icon(
          widget.icon,
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.dataText,
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w400),
        ),
        Spacer(),
        FlatButton(
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(width: 3),
              Text('Edit',
                  style: TextStyle(
                      fontSize: FontSizes.bodySm,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue,
                      decoration: TextDecoration.underline)),
            ],
          ),
          onPressed: toggleEditability,
        )
      ],
    ).ps(x: 20);
  }

  Widget _editingData() {
    return Row(
      children: [
        if (widget.type == 'normal')
          Flexible(
            child: RoundedInput(
              icon: widget.icon,
              initialValue: widget.dataText,
              autofocus: true,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              suffixIcon: widget.suffixIcon,
              onClickedSuffixIcon: widget.onClickedSuffixIcon,
              validator: widget.validator,
            ),
          ),
        if (widget.type == 'date')
          Flexible(
            child: RoundedInput(
              icon: widget.icon,
              initialValue: widget.dataText,
              autofocus: false,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              suffixIcon: widget.suffixIcon,
              onClickedSuffixIcon: widget.onClickedSuffixIcon,
              validator: widget.validator,
            ).ripple(() {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(widget.dataText),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now())
                  .then((date) {
                    var _pickedDate = DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(date.toString()));

                    widget.onChanged(_pickedDate);
                  });
            }),
          ),
        if (widget.type == 'type')
          Flexible(
            child: TextInputController(
              child: DropdownButtonFormField(
                value: widget.dataText,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.icon,
                    color: kPrimaryColor,
                  ),
                ),
                items: organizationType
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        FlatButton(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.done,
                color: Colors.green,
                size: 15,
              ),
              SizedBox(width: 3),
              Text('Done',
                  style: TextStyle(
                      fontSize: FontSizes.bodySm,
                      fontWeight: FontWeight.w300,
                      color: Colors.green,
                      decoration: TextDecoration.underline)),
            ],
          ),
          onPressed: toggleEditability,
        )
      ],
    ).ps(x: 15);
  }
}
