import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_demo/Tabs/model/place.dart';
import 'package:flutter_firebase_demo/Tabs/repository/firebase_storage_repository.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/User/repository/auth_repository.dart';
import 'package:flutter_firebase_demo/User/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  final _firebaseStorageRepository = FirebaseStorageRepository();

  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged; // Stream - Firebase
  Stream<FirebaseUser> get authStatus => streamFirebase; // STATE session
  Future<FirebaseUser> get currentUser =>
      FirebaseAuth.instance.currentUser(); // Id User

  // SigIn to app from Google
  Future<FirebaseUser> sigIn() => _auth_repository.signInFirebase();

  // Register user in db
  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserData(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceDate(place);
  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
