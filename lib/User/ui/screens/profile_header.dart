import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:flutter_firebase_demo/User/model/user.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/button_bar.dart';
import 'package:flutter_firebase_demo/User/ui/widgets/user_info.dart';
import 'package:flutter_firebase_demo/widgets/text_input.dart';
import 'package:flutter_firebase_demo/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfileHeader extends StatelessWidget {
  UserBloc userBloc;
  User user;
//  final _controllerTitle = TextEditingController();
//  final _controllerDescription = TextEditingController();

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
                // fixed on top
                Flexible(
                  child: Container(
                      child: TitleHeader(
                    title: "Profile",
                  )),
                )
              ],
            ),
//            Container(
//              margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
//              child: ListView(
//                children: <Widget>[
//                  Container(
//                    // TextField Title
//                    margin: EdgeInsets.only(bottom: 20.0),
//                    child: TextInput(
//                      hintText: "Title",
//                      inputType: null,
//                      maxLines: 1,
//                      controller: _controllerTitle, // capture data
//
//                    ),
//                  ),
//                  TextInput(
//                    // TextField Description
//                    hintText: "Description",
//                    inputType: TextInputType.multiline,
//                    maxLines: 4,
//                    controller: _controllerDescription,
//                  )
//                ],
//              ),
//            ),
            UserInfo(user),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
