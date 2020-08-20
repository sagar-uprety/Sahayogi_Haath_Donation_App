import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  final String activitydescription;
  final String name;

  Product({this. activitydescription, this.name});
  Map<String, dynamic> toMap(){
    return {
      'activityDescription': activitydescription,
      'name': name,
    };

  }
  Product.fromFirestore(Map<String, dynamic> firestore)
  : activitydescription= firestore['activitydescription'],
    name =  firestore['name'];

}