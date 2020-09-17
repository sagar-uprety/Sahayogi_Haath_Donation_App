class FirestorePath {
  static String user(String uid) => 'users/$uid';
  static String users() => 'users';
  static String activity(String uid) => 'activities/$uid';
  static String activities() => 'activities';
  static String organization(String uid) => 'organizations/$uid';
  static String organizations() => 'organizations';
  static String transaction(String id)=>'transaction/$id';
  static String transactions() => 'transaction';
}
