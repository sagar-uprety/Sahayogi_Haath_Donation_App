class Activity {
  final String description;
  final String name;

  Activity({
    this.description,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'name': name,
    };
  }

  Activity.fromFirestore(Map<String, dynamic> firestore)
      : description = firestore['description'],
        name = firestore['name'];
}
