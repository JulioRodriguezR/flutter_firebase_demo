import 'package:flutter_firebase_demo/Place/model/place.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';

import 'cloud_firestore_api.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserData(User user) => _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceDate(Place place) =>
      _cloudFirestoreAPI.updatePlaceDate(place);
}
