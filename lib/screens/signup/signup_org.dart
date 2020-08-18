import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../models/usermodel.dart';
import '../../provider/auth_provider.dart';
import '../pickers/document_picker.dart';
import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
import '../../components/HaveAnAccount.dart';
import './SignUpBackground.dart';
import '../pickers/user_image_picker.dart';
import '../../constants.dart';

class SignUpOrganization extends StatefulWidget {

  @override
  _SignUpOrganizationState createState() => _SignUpOrganizationState();
}

class _SignUpOrganizationState extends State<SignUpOrganization> {
  final _formKey = GlobalKey<FormState>();
  var _organizationEmail = '';
  var _password = '';
  var _name = '';
  var _phone = '';
  var _address = '';
  var _establishedDate= '';
  var _type='';
  File _userImage;
  File _documentImage;
  
  List<String> organizationType=['Orphange', 'Elderly Care', 'Nursing Home', 'Education', 'Health Treatment', 'Others'];


  bool obscurePassword= true;
  String _pickedDate = '';
  TextEditingController controller;
  String _selectedType='Orphanage';

  void _toggleVisibility(){
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _pickedDocument(File image) {
    _documentImage = image;
  }

  @override
  void dispose() {
    controller.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return SignUpBackground(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(            
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SIGN UP AS AN ORGANIZER',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                UserImagePicker(_pickedImage),
                RoundedInput  (
                  hintText: "Name",
                  key: ValueKey('name'),
                  icon: Icons.people,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Organization\'s Name cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value;
                    print(_name);
                  },
                ),
                RoundedInput(
                  hintText: "Enter Organization's Email",
                  key: ValueKey('email'),
                  icon: Icons.email,
                  enableSuggesstion: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _organizationEmail = value;
                    print(_organizationEmail);
                  },
                ),
                RoundedInput(
                  hintText: "Password",
                  key: ValueKey('password'),
                  icon: Icons.lock,
                  obscureText: obscurePassword,
                  suffixIcon: obscurePassword ? Icons.visibility : Icons.visibility_off,
                  onClickedSuffixIcon: _toggleVisibility,
                  validator: (value) {
                    if (value.isEmpty || value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                    print(_password);
                  },
                ),
                RoundedInput(
                  hintText: "Mobile Number",
                  key: ValueKey('phone'),
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.isEmpty || value.length != 10) {
                      return 'This Phone Number is invalid';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value;
                    print(_phone);
                  },
                ),
                RoundedInput(
                  hintText: "Address",
                  key: ValueKey('address'),
                  icon: Icons.location_on,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Organization\'s Address cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value;
                    print(_address);
                  },
                ),
                RoundedInput(
                  hintText: "Establishment Date",
                  key: ValueKey('date'),
                  controller: controller,
                  icon: Icons.access_time,
                  suffixIcon: Icons.today,
                  onClickedSuffixIcon: (){
                    showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2000), 
                      lastDate: DateTime.now()
                    ).then(
                      (date) {
                        setState(() {
                          _pickedDate = DateFormat("yyyy-MM-dd").format(DateTime.parse(date.toString()));
                          controller = TextEditingController(text: _pickedDate);
                        });
                      }
                    );
                  },
                  keyboardType: TextInputType.datetime,
                  validator: (value){
                    if(value.isNotEmpty || RegExp(r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$').hasMatch(value)){
                      return null;
                    }
                    return 'Invalid Date';
                  },
                  onSaved: (value){
                    _establishedDate = value;
                    print(_establishedDate);
                  },
                ),
                TextInputController(
                  child: DropdownButtonFormField(
                    hint: Text('Organization Type'),
                    // value: _selectedType,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
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
                    onChanged: (value) {
                      setState(() {
                        _selectedType=value;
                      });
                    },
                    onSaved: (value){
                      _type = value;
                      print(value);
                    },
                  ),
                ),
                DocumentPicker(_pickedDocument),
                authProvider.status == Status.Registering
                  ? CircularProgressIndicator()
                  : RoundButton(
                    text: 'SIGN UP',
                    onPress: () async{
                      final isValid = _formKey.currentState.validate();
                      FocusScope.of(context).unfocus();

                      //TODO: Default Image
                      if (_userImage == null) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please pick an image.'),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                        return;
                      }

                      if (_documentImage == null) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please upload a document to prove that you are a legal organization.',
                              ),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                        return;
                      }

                      if (isValid) {
                        _formKey.currentState.save();
                        
                        await authProvider.registerWithEmailAndPasword(
                          name: _name.trim(),
                          email: _organizationEmail.trim(),
                          password: _password,
                          phone: _phone.trim(),
                          address: _address.trim(),
                          establishedDate: _establishedDate.trim(),
                          profileImage: _userImage,
                          documentImage: _documentImage,
                          type: _type,
                          userType: UserType.organization,
                          ctx: context,
                        );

                        Navigator.of(context).pushReplacementNamed(Routes.dashboard);
                      }
                    }
                  ),
                SizedBox(height: size.height * 0.03),
                if (authProvider.status != Status.Registering)
                  HaveAnAccountCheck(
                    login: false,
                    onPress: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                  ),
                SizedBox(height: size.height * 0.03),
              ]
            ),
          ),
        ),
      ),
    );
  }
}