import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_demo/Place/model/place.dart';
import 'package:flutter_firebase_demo/Place/repository/firebase_storage_repository.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/User/repository/auth_repository.dart';
import 'package:flutter_firebase_demo/User/repository/cloud_firestore_api.dart';
import 'package:flutter_firebase_demo/User/repository/cloud_firestore_repository.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/profile_place.dart';
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
  // Listened User files
  Stream<QuerySnapshot> placesListStream =
      Firestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}
