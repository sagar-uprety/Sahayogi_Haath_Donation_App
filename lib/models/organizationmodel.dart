class OrganizationModel{
  final String infoId;
  final String name;
  final String description;

  OrganizationModel({this.infoId, this.description, this.name});

Map<String,dynamic> toMap(){
  return{
    'infoId': infoId,
    'name': name,
    'description': description,
  };
}
OrganizationModel.fromFirestore(Map<String, dynamic> firestore)
       :infoId = firestore['infoId'],
       name = firestore['name'],
       description = firestore['description'];
}