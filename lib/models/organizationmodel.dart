class OrganizationDetail {
  final String organizationID;
  final String description;
  final String title;
  final String image;

  OrganizationDetail({
    this.organizationID,
    this.description,
    this.title,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'organizationID': organizationID,
      'description': description,
      'title': title,
      'image': image
    };
  }

  OrganizationDetail.fromFirestore(Map<String, dynamic> firestore)
      : organizationID = firestore['organizationID'],
        description = firestore['description'],
        title = firestore['title'],
        image = firestore['image'];
}
