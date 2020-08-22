import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getUser() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    print(uid);
    print(user.displayName);
    return uid;
  }
}
