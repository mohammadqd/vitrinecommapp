///
/// Unit Tests  for  box_op package
///

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/service/box_op.dart';
import 'package:uuid_type/uuid_type.dart';

void main() {
  testWidgets("Empty widget test", (tester) async {});

  group('Testing box_op Backend Box Query Service', () {
    // do not block http requests, otherwise we should mock backend
    HttpOverrides.global = null;

    test('Testing Querying a non-existing Box from the Backend Service',
        () async {
      // Arrage
      final testID = Uuid.parse(
          '69F80D07-D77C-4985-9DA0-70A849C66A51'); // non-existing box

      // Act & Assert

      try {
        await queryBox(testID);
        fail("exception not thrown");
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        // more expect statements can go here
      }
    });

    test('Testing Querying an empty Box from the Backend Service', () async {
      // Arrage
      final testID = Uuid.parse(
          '2badab04-0688-45b1-a513-c1060995bf27'); //  box with no asset

      // Act
      final resBox = await queryBox(testID);

      // Assert
      expect(resBox.boxID, testID);
      expect(resBox.boxName, 'TestBox3');
      expect(resBox.asset, null);
    });

    test(
        'Testing Querying a  Box with asset but no owner from the Backend Service',
        () async {
      // Arrage
      final testID = Uuid.parse(
          'fca551a2-d026-460c-bbb4-c97d223c2fa4'); //  box with asset but no owner

      // Act
      final resBox = await queryBox(testID);

      // Assert
      expect(resBox.boxID, testID);
      expect(resBox.boxName, 'TestBox2');
      expect(resBox.asset!.assetName, "TestAsset2");
      expect(resBox.asset!.assetDescription, "Description_for_TestAsset2");
      expect(resBox.asset!.owner, null);
    });

    test(
        'Testing Querying a full Box with asset and owner from the Backend Service',
        () async {
      // Arrage
      final testID =
          Uuid.parse('6CF96E25-71C7-4BF0-A648-CE884D500B0E'); // full box

      // Act
      final resBox = await queryBox(testID);

      // Assert
      expect(resBox.boxID, testID);
      expect(resBox.boxName, 'Adam');
      expect(resBox.asset!.assetName, "luxury purse");
      expect(resBox.asset!.owner!.firstName, "Mohammad");
    });
  });
}
