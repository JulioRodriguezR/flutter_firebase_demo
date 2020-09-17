import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/widgets/gradient_back.dart';
import 'package:flutter_firebase_demo/widgets/title_header.dart';

class AddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: 300.0),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                  child: TitleHeader(title: "Add a new Screen"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
