import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:spotmies/models/placesModel.dart';

class PlacesApi {
  static Future<List<Places>> getLoc(String query) async {
    final url =
        Uri.parse('https://spotmiesserver.herokuapp.com/api/geocode/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List geoLocations = json.decode(response.body);
      log('API Hit');

      return geoLocations.map((json) => Places.fromJson(json)).where((geo) {
        final subLocality = geo.subLocality.toLowerCase();
        final locality = geo.addressLine.toLowerCase();
        final coord = geo.coordinates.toString();
        final searchLower = query.toLowerCase();

        return subLocality.contains(searchLower) ||
            locality.contains(searchLower) ||
            coord.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}