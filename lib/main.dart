import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Enjuru Clothing",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 70, 130, 180)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

