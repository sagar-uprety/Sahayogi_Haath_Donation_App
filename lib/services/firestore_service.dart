import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activitymodel.dart';

class FirestoreService{
  Firestore _db = Firestore.instance;

  Future<void> saveProduct(Product product){
  return  _db.collection('products').document(product.activitydescription).setData(product.toMap());
  }

  Stream<List<Product>> getProducts(){
  return  _db.collection('products').snapshots().map((snapshot) => snapshot.documents.map((document) => Product.fromFirestore(document.data)).toList() );
  }
}