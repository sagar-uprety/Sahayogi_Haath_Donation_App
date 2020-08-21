import 'package:flutter/material.dart';
import 'package:sahayogihaath/theme/theme.dart';
import '../../theme/extention.dart';
import '../../theme/text_styles.dart';

import '../../components/FormInput.dart';
import '../../components/RoundedButton.dart';

class EditActivity extends StatefulWidget {
  static const id = "edit_activities";
  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  final _formKey = GlobalKey<FormState>();
  var _activityTitle = '';
  var _activityDescription = '';

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0XFFfefefe), //manage all theme color
      leading: BackButton(color: Theme.of(context).primaryColor),
      actions: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Image.asset(
              "assets/images1/janko.jpg", //user profile image
              fit: BoxFit.fill,
            ),
          ),
        ).p(9),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Color(0XFFfefefe),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Publish Your Activity',
                    style: TextStyles.title.bold,
                  ),
                  SizedBox(height: AppTheme.fullHeight(context) * 0.02),
                  FormInput(
                    hintText: "Activity Title",
                    key: ValueKey('activity_title'),
                    maxlines: 1,
                    maxlength: 30,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please name your activity';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _activityTitle = value;
                      print(_activityTitle);
                    },
                  ),
                  FormInput(
                    hintText: "Describe your Activity",
                    key: ValueKey('activity_description'),
                    maxlength: 1000,
                    maxlines: 20,
                    enableSuggesstion: false,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _activityDescription = value;
                      print(_activityDescription);
                    },
                  ),
                  RoundButton(
                      text: 'Submit Activity',
                      onPress: () {
                        _formKey.currentState.validate();
                        FocusScope.of(context).unfocus();
                        _formKey.currentState.save();
                        print(_activityTitle);
                        print(_activityDescription);
                        print(_activityTitle);
                        print(_activityDescription);
                        //provider function
                      } //do something
                      ).alignBottomCenter,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
