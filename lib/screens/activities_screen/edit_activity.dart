import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/models/activitymodel.dart';
import 'package:sahayogihaath/provider/activity_provider.dart';
import 'package:sahayogihaath/screens/activities_screen/acitivity_list.dart';

import '../../theme/theme.dart';
import '../../theme/extention.dart';
import '../../theme/text_styles.dart';
import '../../components/FormInput.dart';
import '../../components/RoundedButton.dart';
import '../../routes.dart';

class EditActivity extends StatefulWidget {
  final Activity activity;
  EditActivity([this.activity]);
  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  final activityTitleController = TextEditingController();
  final activityDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //New Record
    if (widget.activity == null) {
      titleController.text = "";
      descriptionController.text = "";
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ActivityProvider>(context, listen: false);
        productProvider.loadValues(Activity());
      });
    } else {
      //Controller Update
      titleController.text = widget.activity.title;
      descriptionController.text = widget.activity.description;
      // State Update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ActivityProvider>(context, listen: false);
        productProvider.loadValues(widget.activity);
      });
    }
    super.initState();
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
                    controller: titleController,
                    hintText: "Activity Title",
                    key: ValueKey('activity_title'),
                    maxlines: 1,
                    maxlength: 30,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      activityProvider.changeTitle(value);
                    },
                  ),
                  FormInput(
                    controller: descriptionController,
                    hintText: "Describe your Activity",
                    key: ValueKey('activity_description'),
                    maxlength: 1000,
                    maxlines: 20,
                    enableSuggesstion: false,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      activityProvider.changeDescription(value);
                    },
                  ),
                  RoundButton(
                      text: 'Submit Activity',
                      onPress: () {
                        bool validated = _formKey.currentState.validate();
                        FocusScope.of(context).unfocus();
                        // _formKey.currentState.save();
                        if (validated) {
                          activityProvider.saveActivity();
                          Navigator.pushReplacementNamed(
                              context, Routes.activities_list);
                        }
                      }).alignBottomCenter,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
}
