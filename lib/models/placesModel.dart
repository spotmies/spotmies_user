
import 'package:flutter/material.dart';

class Places {
  final int id;
  final String subLocality;
  final String addressLine;
  final Map coordinates;
  final int postalCode;

  const Places({
    @required this.id,
    @required this.addressLine,
    @required this.subLocality,
    @required this.coordinates,
    @required this.postalCode,
  });

  factory Places.fromJson(Map<String, dynamic> json) => Places(
        id: json['id'],
        addressLine: json['addressLine'],
        subLocality: json['subLocality'],
        coordinates: json['coordinates'],
        postalCode: json['postalCode'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subLocality': subLocality,
        'addressLine': addressLine,
        'coordinates': coordinates,
        'postalCode': postalCode,
      };
}