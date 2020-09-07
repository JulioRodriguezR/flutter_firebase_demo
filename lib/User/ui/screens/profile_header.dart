import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/button_bar.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/user_info.dart';
import 'package:flutter_firebase_demo/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {
  UserBloc userBloc;
  User user;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.streamFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            return showProfileData(snapshot);
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("The information could not be loaded. You have to login"),
          ],
        ),
      );
    } else {
      user = User(
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoUrl: snapshot.data.photoUrl,
      );

      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(child: TitleHeader(title: "Profile",)),
                )
              ],
            ),
            UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
