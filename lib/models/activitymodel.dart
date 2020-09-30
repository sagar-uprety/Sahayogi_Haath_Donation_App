import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String activityID;
  final String description;
  final String title;
  final String image;
  final String authorid;
  final String authorName;
  final Timestamp time;

  Activity(
      {this.activityID,
      this.description,
      this.title,
      this.image,
      this.authorid,
      this.authorName,
      this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'activityID': activityID,
      'description': description,
      'title': title,
      'image': image,
      'authorid': authorid,
      'author_name': authorName,
      'time': time,
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : activityID = firestore['activityID'],
        description = firestore['description'],
        title = firestore['title'],
        image = firestore['image'],
        authorid = firestore['authorid'],
        authorName = firestore['author_name'],
        time = firestore['time'];
}
