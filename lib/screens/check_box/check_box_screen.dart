import 'package:flutter/material.dart';
import 'package:shop_app/config.dart';
import 'components/body.dart';

///
/// This page checks the requested box id and routes to box screen
///
class CheckBoxScreen extends StatelessWidget {
  static String routeName = "/check_box";
  final String? boxID = uriArguments!["boxID"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Check Box...'),
      ),
      body: Body(boxID: boxID),
    );
  }
}
