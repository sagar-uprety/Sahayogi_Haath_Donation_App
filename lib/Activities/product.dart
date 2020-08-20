import 'package:flutter/material.dart';
import 'package:sahayogihaath/screens/activities/activitiesScreen.dart';
import 'package:provider/provider.dart';
import '../models/activitymodel.dart';


class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ActivitiesScreen(),
            ),
            );
          })
        ]
      ),
      body:(products != null)? ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(products[index].name),
            trailing: Text(products[index].activitydescription),
            onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ActivitiesScreen(),
            )
            );
            }
          );
          Center(
  
        child:  CircularProgressIndicator()
            
          );
        }
        )
    
    );
        

      
    
  }
}