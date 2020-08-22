class Activity {
  final String activityID;
  final String description;
<<<<<<< HEAD
  final String title;
=======
  final String activityTitle;
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f

  Activity({
    this.activityID,
    this.description,
<<<<<<< HEAD
    this.title,
=======
    this.activityTitle,
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
  });

  Map<String, dynamic> toMap() {
    return {
      'activityID': activityID,
      'description': description,
<<<<<<< HEAD
      'title': title,
=======
      'title': activityTitle,
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
<<<<<<< HEAD
      : activityID = firestore['activityID'],
        description = firestore['description'],
        title = firestore['title'];
=======
      : description = firestore['description'],
        activityTitle = firestore['activitytitle'];
>>>>>>> 5d38c0432e9704ac7aed239884a6a461d9894f0f
}
