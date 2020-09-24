import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo/Place/model/place.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';

class CloudFirestoreAPI {
  // Collections
  final String USERS = "users";
  final String PLACES = "places";
  // Bring user entity and make it available to be able to insert in the db
  final Firestore _db = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(User user) async {
    // The last user connect --btn login
    DocumentReference ref = _db.collection(USERS).document(user.uid);

    return await ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'lastSignIn': DateTime.now(),
    }, merge: true);
  }

  Future<void> updatePlaceDate(Place place) async {
    // Automatically create an identifier
    // collection -
    CollectionReference refPlaces = _db.collection(PLACES);

    FirebaseUser user = await _auth.currentUser();
    DocumentReference _userRef = _db.collection(this.USERS).document(user.uid);

    await _auth.currentUser().then((FirebaseUser user) {
      // Unique and incremental identifier
      refPlaces.add({
        'name': place.name,
        'description': place.description,
        'location': place.location,
        'userOwner': _userRef,
        'urlImage': place.urlImage,
      });
    });
  }
}
