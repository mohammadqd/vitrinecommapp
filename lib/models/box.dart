///
/// Box is a model class to present Smart Boxes in Vitrin business
///

import 'package:shop_app/models/asset.dart';
import 'package:uuid_type/uuid_type.dart';

/// Class Box presents boxes in Vitrin
/// each box may contain an asset to sell
class Box {
  final Uuid boxID;
  final String boxName;
  final Asset? asset;
  //final List<String> images;

  Box({
    required this.boxID,
    //required this.images,
    required this.boxName,
    this.asset,
  });

  @override
  String toString() {
    return 'BOX: boxID: $boxID boxName: $boxName Asset: ' +
        ((asset == null) ? 'No Asset' : asset!.toString());
  }
}
