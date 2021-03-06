import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'User/bloc/bloc_user.dart';
import 'User/ui/screens/sigin_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SigInScreen(),
      ),
      bloc: UserBloc(),
    );
  }
}