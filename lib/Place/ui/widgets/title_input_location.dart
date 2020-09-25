import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TextInputLocation extends StatefulWidget {
  final String hintText;
  final IconData iconButton;
  TextEditingController controller;

  TextInputLocation({
    Key key,
    @required this.hintText,
    @required this.iconButton,
    this.controller,
  });

  @override
  _TextInputLocationState createState() => _TextInputLocationState();
}

class _TextInputLocationState extends State<TextInputLocation> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      child: TextField(
        controller: _currentAddress,
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: "Lato",
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: Icon(widget.iconButton),
            onPressed: () {
              _getCurrentLocation();
            },
          ),
          fillColor: Color(0xFFFFFFFF),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0),
          )
        ],
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((onError) {
      print(onError);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });

      String f(TextEditingController x) => x;
      String g(String y) => f(y);
    } catch (onError) {
      print(onError);
    }
  }
}
