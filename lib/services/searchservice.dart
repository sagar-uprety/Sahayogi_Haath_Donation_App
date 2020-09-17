import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchBytitle(String searchField) {
    return Firestore.instance
        .collection('Users')
        .where('title', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
