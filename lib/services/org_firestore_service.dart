import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/organizationmodel.dart';

class OrgFirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveInfo(OrganizationModel organizationmodel) {
    return _db
        .collection('info')
        .document(organizationmodel.infoId)
        .setData(organizationmodel.toMap());
  }

  Stream<List<OrganizationModel>> getInfo() {
    return _db.collection('info').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => OrganizationModel.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeInfo(String infoId) {
    return _db.collection('info').document(infoId).delete();
  }
}
