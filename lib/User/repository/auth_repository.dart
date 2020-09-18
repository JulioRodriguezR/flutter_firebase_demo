import 'package:firebase_auth/firebase_auth.dart';

import 'current-email_authd.dart';
import 'firebase_auth.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  final _currentEmailAuthAPI = CurrentEmailAuthlAPI();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.sigIn();
  Future<bool> sigInEmailFirebase() => _currentEmailAuthAPI.sigIn();

  signOut() => _firebaseAuthAPI.signOut();
  signEmailOut() => _currentEmailAuthAPI.signOut();
}
