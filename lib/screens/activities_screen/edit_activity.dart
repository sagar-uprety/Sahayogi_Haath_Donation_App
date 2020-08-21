import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/provider_/activity_provider.dart';
import 'package:sahayogihaath/screens/activities_screen/activity_info.dart';

import '../../theme/theme.dart';
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

  void _submitActivity() {}
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
    final activityProvider = Provider.of<ActivityProvider>(context);
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
                    onChanged: (value) {
                      activityProvider.changeTitle(value);
                    },
                  ),
                  FormInput(
                    hintText: "Describe your Activity",
                    key: ValueKey('activity_description'),
                    maxlength: 1000,
                    maxlines: 20,
                    enableSuggesstion: false,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      activityProvider.changeDescription(value);
                    },
                  ),
                  RoundButton(
                      text: 'Submit Activity',
                      onPress: () {
                        _formKey.currentState.validate();
                        FocusScope.of(context).unfocus();
                        // _formKey.currentState.save();
                        activityProvider.saveActivity();
                      }).alignBottomCenter,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
