import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';

class Place {
  String id;
  String name;
  String description;
  String location;
  String urlImage;
  int likes;
  User userOwner;

  Place({
    Key key,
    @required this.name,
    @required this.description,
    @required this.urlImage,
    this.userOwner,
    this.location,
    this.likes,
  });
}
