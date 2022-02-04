///
/// Asset is a model class to present products in Vitrin business
///

import 'package:shop_app/models/person.dart';
import 'package:uuid_type/uuid_type.dart';

/// Class asset presents items to sell or buy in Vitrin
class Asset {
  final Uuid assetID;
  final Person? owner;
  final String? assetName;
  final String? assetDescription;
  //final List<String> images;
  final double? price;

  Asset({
    required this.assetID,
    //required this.images,
    this.owner,
    this.price,
    this.assetName,
    this.assetDescription,
  });

  @override
  String toString() {
    return 'assetID: $assetID assetName: $assetName price: $price Owner: ' +
        ((owner == null) ? 'No Owner' : owner!.toString());
  }
}
