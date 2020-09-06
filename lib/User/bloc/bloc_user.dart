import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/User/repository/auth_repository.dart';
import 'package:flutter_firebase_demo/User/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged; // Stream - Firebase
  Stream<FirebaseUser> get authStatus => streamFirebase; // STATE session

  // SigIn to app from Google
  Future<FirebaseUser> sigIn() {
    return _auth_repository.signInFirebase();
  }

  // Register user in db
  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserData(user);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
