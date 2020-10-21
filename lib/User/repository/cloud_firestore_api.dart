import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_demo/Place/model/place.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/profile_place.dart';

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
    final CollectionReference refPlaces = _db.collection(PLACES);

    final FirebaseUser user = await _auth.currentUser();
    // Get the user's data with the specific id
    final DocumentReference _userRef =
        _db.collection(this.USERS).document(user.uid);

    await _auth.currentUser().then((FirebaseUser user) {
      // Unique and incremental identifier
      refPlaces.add({
        'name': place.name,
        'description': place.description,
        'location': place.location,
        'userOwner': _userRef,
        'urlImage': place.urlImage,
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          snapshot.documentID;
          _userRef.updateData({
            'registerPlaces': FieldValue.arrayUnion(
              [_db.document("$PLACES/${snapshot.documentID}")],
            ),
          });
        });
      });
    });
  }

// Process firebase data
  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = List<ProfilePlace>();
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(Place(
          name: p.data['name'],
          description: p.data['description'],
          urlImage: p.data['urlImage'])));
    });

    return profilePlaces;
  }
}
