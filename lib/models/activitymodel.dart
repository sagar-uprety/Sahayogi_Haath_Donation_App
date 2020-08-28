class Activity {
  final String activityID;
  final String description;
  final String title;

  Activity({
    this.activityID,
    this.description,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityID': activityID,
      'description': description,
      'title': title,
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : activityID = firestore['activityID'],
        description = firestore['description'],
        title = firestore['title'];
}
