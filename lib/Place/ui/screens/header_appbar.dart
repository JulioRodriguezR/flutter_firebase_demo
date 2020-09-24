import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/widgets/gradient_back.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        GradientBack(height: 250.0),
      ],
    );
  }
}
