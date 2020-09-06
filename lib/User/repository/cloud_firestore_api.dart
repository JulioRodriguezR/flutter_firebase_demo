import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';

class CloudFirestoreAPI {
  // Collections
  final String USERS = "users";

  // Bring user entity and make it available to be able to insert in the db
  final Firestore _db = Firestore.instance;

  void updateUserData(User user) async {
    // The last user connect --btn login
    DocumentReference ref = _db.collection(USERS).document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'lastSignIn': DateTime.now(),
    }, merge: true);
  }
}
