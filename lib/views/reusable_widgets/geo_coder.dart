


import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:io';



class Geocoder {
  static final Geocoding local = LocalGeocoding();
  static Geocoding google(
    String apiKey, {
    String? language,
    Map<String, Object>? headers,
    bool preserveHeaderCase = false,
  }) =>
      GoogleGeocoding(apiKey,
          language: language!,
          headers: headers!,
          preserveHeaderCase: preserveHeaderCase);
}




@immutable
class Coordinates {
  /// The geographic coordinate that specifies the north–south position of a point on the Earth's surface.
  final double latitude;

  /// The geographic coordinate that specifies the east-west position of a point on the Earth's surface.
  final double longitude;

  Coordinates(this.latitude, this.longitude);

  /// Creates coordinates from a map containing its properties.
  Coordinates.fromMap(Map map)
      : this.latitude = map["latitude"],
        this.longitude = map["longitude"];

  /// Creates a map from the coordinates properties.
  Map toMap() => {
        "latitude": this.latitude,
        "longitude": this.longitude,
      };

  String toString() => "{$latitude,$longitude}";
}

@immutable
class Address {
  /// The geographic coordinates.
  final Coordinates? coordinates;

  /// The formatted address with all lines.
  final String? addressLine;

  /// The localized country name of the address.
  final String? countryName;

  /// The country code of the address.
  final String? countryCode;

  /// The feature name of the address.
  final String? featureName;

  /// The postal code.
  final String? postalCode;

  /// The administrative area name of the address
  final String? adminArea;

  /// The administrative area code of the address
  final String? adminAreaCode;

  /// The sub-administrative area name of the address
  final String? subAdminArea;

  /// The locality of the address
  final String? locality;

  /// The sub-locality of the address
  final String? subLocality;

  /// The thoroughfare name of the address
  final String? thoroughfare;

  /// The sub-thoroughfare name of the address
  final String? subThoroughfare;

  Address({
    this.coordinates,
    this.addressLine,
    this.countryName,
    this.countryCode,
    this.featureName,
    this.postalCode,
    this.adminArea,
    this.adminAreaCode,
    this.subAdminArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  /// Creates an address from a map containing its properties.
  Address.fromMap(Map map)
      : this.coordinates = new Coordinates.fromMap(map["coordinates"]),
        this.addressLine = map["addressLine"],
        this.countryName = map["countryName"],
        this.countryCode = map["countryCode"],
        this.featureName = map["featureName"],
        this.postalCode = map["postalCode"],
        this.locality = map["locality"],
        this.subLocality = map["subLocality"],
        this.adminArea = map["adminArea"],
        this.adminAreaCode = map["adminAreaCode"],
        this.subAdminArea = map["subAdminArea"],
        this.thoroughfare = map["thoroughfare"],
        this.subThoroughfare = map["subThoroughfare"];

  /// Creates a map from the address properties.
  Map toMap() => {
        "coordinates": this.coordinates?.toMap(),
        "addressLine": this.addressLine,
        "countryName": this.countryName,
        "countryCode": this.countryCode,
        "featureName": this.featureName,
        "postalCode": this.postalCode,
        "locality": this.locality,
        "subLocality": this.subLocality,
        "adminArea": this.adminArea,
        "adminAreaCode": this.adminAreaCode,
        "subAdminArea": this.subAdminArea,
        "thoroughfare": this.thoroughfare,
        "subThoroughfare": this.subThoroughfare,
      };
}




abstract class Geocoding {

  /// Search corresponding addresses from given [coordinates].
  Future<List<Address>> findAddressesFromCoordinates(Coordinates coordinates);

  /// Search for addresses that matches que given [address] query.
  Future<List<Address>> findAddressesFromQuery(String address);
}



/// Geocoding and reverse geocoding through requests to Google APIs.
class GoogleGeocoding implements Geocoding {
  static const _host = 'https://maps.google.com/maps/api/geocode/json';

  final String apiKey;
  final String? language;
  final Map<String, Object>? headers;
  final bool preserveHeaderCase;

  final HttpClient _httpClient;

  GoogleGeocoding(
    this.apiKey, {
    this.language,
    this.headers,
    this.preserveHeaderCase = false,
  }) : _httpClient = HttpClient();

  Future<List<Address>> findAddressesFromCoordinates(
      Coordinates coordinates) async {
    final url =
        '$_host?key=$apiKey${language != null ? '&language=' + language! : ''}&latlng=${coordinates.latitude},${coordinates.longitude}';
    return await _send(url) ?? const <Address>[];
  }

  Future<List<Address>> findAddressesFromQuery(String address) async {
    var encoded = Uri.encodeComponent(address);
    final url = '$_host?key=$apiKey&address=$encoded';
    return await _send(url) ?? const <Address>[];
  }

  Future<List<Address>?> _send(String url) async {
    //print("Sending $url...");
    final uri = Uri.parse(url);
    final request = await this._httpClient.getUrl(uri);
    if (headers != null) {
      headers!.forEach((key, value) {
        request.headers.add(key, value, preserveHeaderCase: preserveHeaderCase);
      });
    }
    final response = await request.close();
    final responseBody = await utf8.decoder.bind(response).join();
    //print("Received $responseBody...");
    var data = jsonDecode(responseBody);

    var results = data["results"];

    if (results == null) return null;

    return results
        .map(_convertAddress)
        .map<Address>((map) => Address.fromMap(map))
        .toList();
  }

  Map? _convertCoordinates(dynamic geometry) {
    if (geometry == null) return null;

    var location = geometry["location"];
    if (location == null) return null;

    return {
      "latitude": location["lat"],
      "longitude": location["lng"],
    };
  }

  Map _convertAddress(dynamic data) {
    Map result = Map();

    result["coordinates"] = _convertCoordinates(data["geometry"]);
    result["addressLine"] = data["formatted_address"];

    var addressComponents = data["address_components"];

    addressComponents.forEach((item) {
      List types = item["types"];

      if (types.contains("route")) {
        result["thoroughfare"] = item["long_name"];
      } else if (types.contains("street_number")) {
        result["subThoroughfare"] = item["long_name"];
      } else if (types.contains("country")) {
        result["countryName"] = item["long_name"];
        result["countryCode"] = item["short_name"];
      } else if (types.contains("locality")) {
        result["locality"] = item["long_name"];
      } else if (types.contains("postal_code")) {
        result["postalCode"] = item["long_name"];
      } else if (types.contains("postal_code")) {
        result["postalCode"] = item["long_name"];
      } else if (types.contains("administrative_area_level_1")) {
        result["adminArea"] = item["long_name"];
        result["adminAreaCode"] = item["short_name"];
      } else if (types.contains("administrative_area_level_2")) {
        result["subAdminArea"] = item["long_name"];
      } else if (types.contains("sublocality") ||
          types.contains("sublocality_level_1")) {
        result["subLocality"] = item["long_name"];
      } else if (types.contains("premise")) {
        result["featureName"] = item["long_name"];
      }

      result["featureName"] = result["featureName"] ?? result["addressLine"];
    });

    return result;
  }
}




/// Geocoding and reverse geocoding through built-lin local platform services.
class LocalGeocoding implements Geocoding {
  static const MethodChannel _channel = MethodChannel('github.com/aloisdeniel/geocoder');

  Future<List<Address>> findAddressesFromCoordinates(Coordinates coordinates) async  {
    Iterable addresses = await _channel.invokeMethod('findAddressesFromCoordinates', coordinates.toMap());
    return addresses.map((x) => Address.fromMap(x)).toList();
  }

  Future<List<Address>> findAddressesFromQuery(String address) async {
    Iterable coordinates = await _channel.invokeMethod('findAddressesFromQuery', { "address" : address });
    return coordinates.map((x) => Address.fromMap(x)).toList();
  }
}