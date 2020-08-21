class Activity {
  final String description;
  final String activityTitle;

  Activity({
    this.description,
    this.activityTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'title': activityTitle,
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : description = firestore['description'],
        activityTitle = firestore['activitytitle'];
}
