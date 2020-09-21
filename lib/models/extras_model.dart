class OrganizationDetail {
  final String id;
  final String name;
  final String description;
  final String bannerImage;

  OrganizationDetail({
    this.id,
    this.name,
    this.description,
    this.bannerImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'banner_image': bannerImage
    };
  }

  OrganizationDetail.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        name = firestore['name'],
        description = firestore['description'],
        bannerImage = firestore['banner_image'];
}
