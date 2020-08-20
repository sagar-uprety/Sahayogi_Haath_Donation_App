import 'package:flutter/material.dart';
import 'Activitiy.dart';
import 'package:provider/provider.dart';
import '../../models/activitymodel.dart';

class Activities extends StatefulWidget {
  static const id = "show";
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Activity>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, ActivitiesScreen.id);
              })
        ],
      ),
      body: (products != null)
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(products[index].name),
                    trailing: Text(products[index].description),
                    onTap: () {
                      // insert detail page route here. But add that in main.dart first
                      // Navigator.pushNamed(context, routeName)
                    });
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
