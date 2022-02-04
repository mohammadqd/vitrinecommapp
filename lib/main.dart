import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/check_box/check_box_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

import 'config.dart';

void main() {
  uriArguments = Uri.base.queryParameters; // save uri arguments in the globals
  final String? boxID =
      Uri.base.queryParameters["boxID"]; //get parameter with attribute "boxID"

  runApp(MyApp(boxID: boxID));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String? boxID;
  MyApp({this.boxID}); //constructor of MyApp class

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vitrin',
      theme: theme(),
      home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute:
          (boxID == null) ? SplashScreen.routeName : CheckBoxScreen.routeName,
      routes: routes,
    );
  }
}
