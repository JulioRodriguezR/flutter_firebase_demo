import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_auth.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.sigIn();

  signOut() => _firebaseAuthAPI.signOut();
}
