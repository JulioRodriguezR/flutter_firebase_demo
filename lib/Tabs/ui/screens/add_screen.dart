import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Tabs/model/place.dart';
import 'package:flutter_firebase_demo/Tabs/ui/widgets/card_image.dart';
import 'package:flutter_firebase_demo/Tabs/ui/widgets/title_input_location.dart';
import 'package:flutter_firebase_demo/User/bloc/bloc_user.dart';
import 'package:flutter_firebase_demo/widgets/button_purple.dart';
import 'package:flutter_firebase_demo/widgets/gradient_back.dart';
import 'package:flutter_firebase_demo/widgets/text_input.dart';
import 'package:flutter_firebase_demo/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddScreen extends StatefulWidget {
  File image;

  AddScreen({Key key, this.image});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();

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
                  child: TitleHeader(title: "Add a new Place"),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    pathImage: widget.image.path,
                    iconData: Icons.camera_alt,
                    width: 350.0,
                    height: 250.0,
                    left: 0,
                    onPressedFabIcon: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextInput(
                    hintText: "Title",
                    inputType: null,
                    maxLines: 1,
                    controller: _controllerTitlePlace,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: TextInput(
                    hintText: "Title",
                    inputType: null,
                    maxLines: 1,
                    controller: _controllerTitlePlace,
                  ),
                ),
                TextInput(
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  maxLines: 4,
                  controller: _controllerDescriptionPlace,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextInputLocation(
                    hintText: "Add Location",
                    iconData: Icons.location_on,
                  ),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Add Place",
                    onPressed: () {
                      userBloc.currentUser.then((FirebaseUser user) {
                        // ID currently logged in user
                        if (user != null) {
                          String uid = user.uid;
                          String path = "$uid/${DateTime.now().toString()}.jpg";
                          // Firebase storage
                          // url -
                          userBloc
                              .uploadFile(path, widget.image)
                              .then((StorageUploadTask storageUploadTask) {
                            storageUploadTask.onComplete.then((value) {
                              // Value of upload image
                              storageUploadTask.onComplete
                                  .then((StorageTaskSnapshot snapshot) {
                                snapshot.ref.getDownloadURL().then((urlImage) {
                                  print(urlImage);
                                });
                              });
                            });
                          });
                        }
                      });

                      // Cloud Firestore
                      userBloc
                          .updatePlaceData(Place(
                        name: _controllerDescriptionPlace.text,
                        description: _controllerDescriptionPlace.text,
                      ))
                          .whenComplete(() {
                        print("Finish");
                        Navigator.pop(context);
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
