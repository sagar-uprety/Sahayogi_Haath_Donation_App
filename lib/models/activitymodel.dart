class Activity {
  final String activityID;
  final String description;
  final String title;
  final String image;

  Activity({
    this.activityID,
    this.description,
    this.title,
    this.image
  });

  Map<String, dynamic> toMap() {
    return {
      'activityID': activityID,
      'description': description,
      'title': title,
      'image': image
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : activityID = firestore['activityID'],
        description = firestore['description'],
        title = firestore['title'],
        image = firestore['image'];
}
