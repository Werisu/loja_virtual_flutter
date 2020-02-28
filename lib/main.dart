import 'package:flutter/material.dart';
import 'package:lopa_app_flutter/Screens/login_screen.dart';
import 'package:lopa_app_flutter/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Enjuru Clothing",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 70, 130, 180)
        ),
        debugShowCheckedModeBanner: false,
        //home: HomeScreen(),
        home: HomeScreen(),
      ),
    );
  }
}

