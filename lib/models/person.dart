///
/// Person is a model class to present owners in Vitrin business
///

import 'package:uuid_type/uuid_type.dart';

/// Class Person presents owners of assets in Vitrin
class Person {
  final Uuid personID;
  final String? firstName;
  final String? familyName;
  final String? personalNumber;
  final String? address;
  final String? mobileNumber;

  Person({
    required this.personID,
    this.firstName,
    this.familyName,
    this.personalNumber,
    this.address,
    this.mobileNumber,
  });

  @override
  String toString() {
    return '''personID: $personID firstName: $firstName familyName: $familyName personalNumber: 
    $personalNumber address: $address mobileNumber: $mobileNumber''';
  }
}
