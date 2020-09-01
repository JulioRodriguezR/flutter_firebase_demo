import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo/User/repository/auth_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  // Stream - Firebase
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;

  // STATE session
  Stream<FirebaseUser> get authStatus => streamFirebase;

  // SigIn to app from Google
  Future<FirebaseUser> sigIn() {
    return _auth_repository.signInFirebase();
  }

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
