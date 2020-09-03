class FirestorePath {
  static String user(String uid) => 'users/$uid';
  static String activity(String uid) => 'activities/$uid';
  static String activities() => 'activities';
  static String organization(String uid) => 'organizations/$uid';
  static String organizations() => 'organizations';

}
