import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/asset.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/service/box_op.dart';
import 'package:shop_app/size_config.dart';
import 'package:uuid_type/uuid_type.dart';

class Body extends StatelessWidget {
  final String? boxID;

  const Body({Key? key, this.boxID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the requested box and go to deatils page to present it
    try {
      final boxUuid = Uuid.parse(boxID!);
      final resBox = queryBox(boxUuid);
      resBox.then((value) {
        print(value.toString());
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(
              product:
                  Product.fromAsset(value.asset ?? Asset(assetID: Uuid.nil))),
        );
      }).onError((error, stackTrace) {
        log('Error in retrieving a box: $error');
      });
    } catch (e) {
      log('Error in retrieving box process: $e');
    }
    // this is the waiting page
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Checking Box ...",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
