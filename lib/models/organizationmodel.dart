class OrganizationDetail {
  final String organizationID;
  final String description;
  final String title;
  final String image;
  final String searchKey;

  OrganizationDetail({
    this.organizationID,
    this.description,
    this.title,
    this.image,
    this.searchKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'organizationID': organizationID,
      'description': description,
      'title': title,
      'image': image,
      'searchKey': searchKey
    };
  }

  OrganizationDetail.fromFirestore(Map<String, dynamic> firestore)
      : organizationID = firestore['organizationID'],
        description = firestore['description'],
        title = firestore['title'],
        image = firestore['image'],
        searchKey = firestore['searchKey'];
}
