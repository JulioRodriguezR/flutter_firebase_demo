import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class CurrentEmailAuthlAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> sigIn() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      return false;
    }
    return user.isEmailVerified;
  }

  signOut() async {
    await _auth.signOut().then((onValue) => print("sign out"));
  }
}
