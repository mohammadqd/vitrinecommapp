///
/// This module provides access to BOX Retrieve backend service
///
///

import 'dart:convert';
import 'dart:developer';
import 'package:shop_app/config.dart' as config;
import 'package:shop_app/models/asset.dart';
import 'package:shop_app/models/box.dart';
import 'package:shop_app/models/person.dart';
import 'package:uuid_type/uuid_type.dart';
import 'package:http/http.dart' as http;

///
/// Query a box from backend
///
/// [requestedBoxID] the uuid of requested box
/// NOTE: Exception handling is necessary for calling this function as
/// in case of connection to backend and result parsing it may throw exceptions
///
Future<Box> queryBox(Uuid requestedBoxID) async {
  log('Requested Box from Backend: BoxID: $requestedBoxID');

  //
  // STEP 1: Call backend service and get the result as a JSON
  //

  final uri = Uri.parse(config.boxOpBKServiceURI).replace(queryParameters: {
    'boxID': requestedBoxID.toString(),
  });
  final response = await http.get(uri);

  //
  // STEP 2: Check the response and extract the result from JSON
  //

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // if box is not found
    if (response.body.length == 0) {
      throw Exception('Box Not Found!');
    } else {
      var result = jsonDecode(response.body);
      // if box without asset
      if (result["assetID"] == null) {
        return Box(boxID: requestedBoxID, boxName: result["boxName"]);
        // if box with asset but no owner
      } else if (result["ownerID"] == null) {
        final asset = Asset(
          assetID: Uuid.parse(result["assetID"]),
          assetName: result["assetName"],
          price: double.parse(result["price"]),
        );
        return Box(
            boxID: requestedBoxID, asset: asset, boxName: result["boxName"]);
        // if box has asset and asset has owner
      } else {
        final owner = Person(
          personID: Uuid.parse(result["ownerID"]),
          firstName: result["firstName"],
          familyName: result["familyName"],
          personalNumber: result["personalNumber"],
          address: result["address"],
          mobileNumber: result["mobileNumber"],
        );
        final asset = Asset(
          assetID: Uuid.parse(result["assetID"]),
          owner: owner,
          assetName: result["assetName"],
          price: double.parse(result["price"]),
        );
        return Box(
            boxID: requestedBoxID, asset: asset, boxName: result["boxName"]);
      }
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    log("bad response from the backend service box_op");
    throw Exception(
        "Failed to receive valid result from the backend service box_op!");
  }
}

/*
void main() {
  log('testing box op service...');
  //final testID = Uuid.parse('6CF96E25-71C7-4BF0-A648-CE884D500B0E'); // full box
  //final testID = Uuid.parse('fca551a2-d026-460c-bbb4-c97d223c2fa4'); // box with asset but no owner
  //final testID = Uuid.parse('2badab04-0688-45b1-a513-c1060995bf27'); // box with no asset
  final testID = Uuid.parse('69F80D07-D77C-4985-9DA0-70A849C66A51'); // non-existing box

  final resBox = queryBox(testID);
  resBox
      .then((value) => print(value.toString()))
      .onError((error, stackTrace) => log(error.toString()));
}

*/
