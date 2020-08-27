import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/profile_background.dart';

import 'profile_header.dart';

class ProfileTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader()
          ],
        ),
      ],
    );
  }
}
