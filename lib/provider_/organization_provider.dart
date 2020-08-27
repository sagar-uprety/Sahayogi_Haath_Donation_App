import 'package:flutter/material.dart';
import 'package:sahayogihaath/models/organizationmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

import '../services/org_firestore_service.dart';

class OrganizationProvider with ChangeNotifier {
  final firestoreService = OrgFirestoreService();
  String _name;
  String _description;
  String _infoId;
  var uuid = Uuid();

  //Getters

  String get name => _name;
  String get description => _description;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  loadValues(OrganizationModel organizationModel) {
    _name = organizationModel.name;
    _description = organizationModel.description;
    _infoId = organizationModel.infoId;
  }

  saveInfo() {
    if (_infoId == null) {
      //Create new info
      var newInfo = OrganizationModel(
          name: name, description: description, infoId: uuid.v4());
      firestoreService.saveInfo(newInfo);
    } else {
      var updateInfo = OrganizationModel(
          name: name, description: description, infoId: uuid.v4());
      firestoreService.saveInfo(updateInfo);
    }
    notifyListeners();
  }

  removeInfo(String infoId) {
    firestoreService.removeInfo(infoId);
    notifyListeners();
  }
}
