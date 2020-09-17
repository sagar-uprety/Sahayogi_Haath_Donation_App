class OrganizationDetail {
  final String organizationID;
  final String description;
  final String bannerImage;

  OrganizationDetail({
    this.organizationID,
    this.description,
    this.bannerImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'organizationID': organizationID,
      'description': description,
      'banner_image': bannerImage
    };
  }

  OrganizationDetail.fromFirestore(Map<String, dynamic> firestore)
      : organizationID = firestore['organizationID'],
        description = firestore['description'],
        bannerImage = firestore['banner_image'];
}
