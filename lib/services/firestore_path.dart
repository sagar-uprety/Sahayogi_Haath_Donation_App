class FirestorePath{
  static String user(String uid) => 'users/$uid';
  static String activity(String uid) => 'activities/$uid';
  static String activities() => 'activities';
  static String transaction(String id)=>'transaction/$id';
  static String transactions() => 'transaction';
}