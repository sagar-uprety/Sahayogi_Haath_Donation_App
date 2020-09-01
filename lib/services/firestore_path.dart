class FirestorePath{
  static String user(String uid) => 'users/$uid';
  static String activity(String uid) => 'activities/$uid';
  static String activities() => 'activities';
}