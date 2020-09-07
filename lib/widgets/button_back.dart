import 'package:flutter/material.dart';

class ButtonBack extends StatefulWidget {
  double height = 0.0;
  double width = 0.0;
  double sizeIcon = 0.0;
  final VoidCallback onPressed;

  ButtonBack({Key key, @required this.onPressed, this.height, this.width});

  @override
  State<StatefulWidget> createState() {
    return _ButtonBack();
  }
}

class _ButtonBack extends State<ButtonBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
          size: widget.sizeIcon,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
