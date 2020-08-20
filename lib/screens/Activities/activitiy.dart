import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider_/activity_provider.dart';
import 'product.dart';

class ActivitiesScreen extends StatefulWidget {
  static const id = "activities_form";
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ActivityProvider>(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'title',
            ),
            onChanged: (value) {
              productProvider.changeName(value);
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'description',
            ),
            onChanged: (value) {
              productProvider.changeDescription(value);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              productProvider.saveActivity();
              Navigator.pushNamed(context, Products.id);
            },
          ),
        ],
      ),
    );
  }
}
