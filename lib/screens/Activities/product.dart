import 'package:flutter/material.dart';
import '../Activities/Activities.dart';
import 'package:provider/provider.dart';
import '../../models/activitymodel.dart';

class Products extends StatefulWidget {
  static const id = "show";
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
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
