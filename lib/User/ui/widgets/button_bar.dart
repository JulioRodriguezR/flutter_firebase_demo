import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Tabs/ui/screens/add_screen.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

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
            true,
            Icons.vpn_key,
            20.0,
            Color.fromRGBO(255, 255, 255, 0.6),
            () => {},
          ),
          CircleButton(
            false,
            Icons.add,
            40.0,
            Color.fromRGBO(255, 255, 255, 1),
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AddScreen(),
                ),
              ),
            },
          ),
          CircleButton(
            true,
            Icons.exit_to_app,
            20.0,
            Color.fromRGBO(255, 255, 255, 0.6),
            () => {
              userBloc.signOut(),
            },
          ),
        ],
      ),
    );
  }
}
