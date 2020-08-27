import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../components/RoundedInput.dart';
import '../../components/RoundedButton.dart';
<<<<<<< HEAD
import '../../components/Registration/HaveAnAccount.dart';
import '../../components/Registration/SocialIcons.dart';
import '../login/login_main.dart';
=======
import '../../components/HaveAnAccount.dart';
>>>>>>> dipesh-test
import './SignUpBackground.dart';
import '../pickers/user_image_picker.dart';
import '../../provider/auth_provider.dart';
import '../../models/usermodel.dart';
import '../../routes.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  var _name = '';
  var _phone = '';
  var _address = '';
  File _userImage;

  bool obscurePassword= true;

  void _toggleVisibility(){
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _pickedImage(File image) {
    _userImage = image;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return SignUpBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SIGN UP',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25.0,
                ),
              ),
              /*    SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                'assets/icons/signup.svg',
                height: size.height * 0.,
              ), */
              SizedBox(height: size.height * 0.04),
              UserImagePicker(_pickedImage),
              RoundedInput(
                hintText: "Full Name",
                key: ValueKey('name'),
                icon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Your Name cannot be empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                  print(_name);
                },
              ),
              RoundedInput(
                hintText: "Enter Your Email",
                icon: Icons.person,
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
                  _userEmail = value;
                  print(_userEmail);
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
                  _userPassword = value;
                  print(_userPassword);
                },
              ),
              RoundedInput(
                hintText: "Mobile Number",
                key: ValueKey('phone'),
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty || value.length != 10) {
                    return 'Your Phone Number is invalid';
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
                    return 'Your Address cannot be empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value;
                  print(_address);
                },
              ),
              authProvider.status==Status.Registering 
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
                    if(isValid) {
                      _formKey.currentState.save();
                      await authProvider.registerWithEmailAndPasword(
                        name: _name.trim(),
                        email: _userEmail.trim(),
                        password: _userPassword,
                        phone: _phone.trim(),
                        address: _address.trim(),
                        profileImage: _userImage,
                        userType: UserType.donor,
                        ctx: context,
                      ).catchError((e){
                        print(e);
                      });
                    }
                  },
                ),
              SizedBox(height: size.height * 0.03),
              if(authProvider.status != Status.Registering)
                HaveAnAccountCheck(
                  login: false,
                  onPress: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
