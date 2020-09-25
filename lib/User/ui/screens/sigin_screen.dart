import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/widgets/button_green.dart';
import 'package:flutter_firebase_demo/widgets/gradient_back.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import '../../../nav_trips_cupertino.dart';

class SigInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SigInScreen();
  }
}

class _SigInScreen extends State<SigInScreen> {
  UserBloc userBloc;
  double screenWidget;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      // response of stream
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // snapshot- data - Obj User (Firebase)
        if (!snapshot.hasData || snapshot.hasError) {
          return sigInGoogleUI();
        } else {
          return NavTripsCupertino();
        }
      },
    );
  }

  Widget sigInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(height: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  width: screenWidget,
                  child: Text(
                    "Welcome\nThis is your Best App",
                    style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ButtonGreen(
                txt: "Login with Gmail",
                onPressed: () {
                  userBloc.signOut();
                  userBloc.sigIn().then((FirebaseUser user) {
                    userBloc.updateUserData(User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoUrl: user.photoUrl,
                    ));
                  });
                },
                width: 300.0,
                height: 50.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
