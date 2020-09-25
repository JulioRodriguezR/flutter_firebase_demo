import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Place/ui/screens/add_screen.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          CircleButton(
            mini: true,
            icon: Icons.vpn_key,
            iconSize: 20.0,
            color: Color.fromRGBO(255, 255, 255, 0.6),
            onPressed: () => {},
          ),
          CircleButton(
            mini: false,
            icon: Icons.add,
            iconSize: 40.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            onPressed: () => {
              // Acess to camera
              ImagePicker.pickImage(source: ImageSource.camera).then(
                (File img) {
                  if (img != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddScreen(image: img),
                      ),
                    );
                  }
                },
              ).catchError(
                (onError) => print(onError),
              )
            },
          ),
          CircleButton(
            mini: true,
            icon: Icons.exit_to_app,
            iconSize: 20.0,
            color: Color.fromRGBO(255, 255, 255, 0.6),
            onPressed: () => {
              userBloc.signOut(),
            },
          ),
        ],
      ),
    );
  }
}
