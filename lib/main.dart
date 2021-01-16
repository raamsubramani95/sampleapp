import 'package:flutter/material.dart';
import 'package:teamemployees/utils/constants.dart';
import 'SplashScreen.dart';
import 'screens/Home.dart';


void main() => runApp(Mainapp());

class Mainapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        OFFLINE_USER_LIST_ROUTE: (context) => Myhomescreen(),
      },
    );
  }
}