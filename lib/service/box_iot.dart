///
/// This module provides IoT access to BOX backend service
///
///

import 'dart:convert';
import 'dart:developer';
import 'package:shop_app/config.dart' as config;
import 'package:uuid_type/uuid_type.dart';
import 'package:http/http.dart' as http;

///
/// Command a box through backend
///
/// This method receives [requestedBoxID] as the uuid of requested box and sends
/// command to BK Service boxIoTOP to open the box. It returns true if the box is
/// open and false otherwise. It may also throw Exception in case of any problem
///
Future<bool> openBox(Uuid requestedBoxID) async {
  log('Open a Box through Backend: BoxID: $requestedBoxID');

  //
  // STEP 1: Call backend service and get the result as a JSON
  //

  final uri = Uri.parse(config.boxIoTBKServiceURI).replace(queryParameters: {
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
      // if box is open return true
      if (result["boxStatus"] == "open")
        return true;
      else
        return false;
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    log("bad response from the backend service boxIoTOP");
    throw Exception(
        "Failed to receive valid result from the backend service boxIoTOP!");
  }
}

/*
void main() {
  log('testing box op service...');
  //final testID = Uuid.parse('6CF96E25-71C7-4BF0-A648-CE884D500B0E'); // full box
  final testID = Uuid.parse(
      'fca551a2-d026-460c-bbb4-c97d223c2fa4'); // box with asset but no owner
  //final testID = Uuid.parse('2badab04-0688-45b1-a513-c1060995bf27'); // box with no asset
  //final testID = Uuid.parse('69F80D07-D77C-4985-9DA0-70A849C66A51'); // non-existing box

  final resBox = openBox(testID);
  resBox
      .then((value) => print(value.toString()))
      .onError((error, stackTrace) => log(error.toString()));
}
*/