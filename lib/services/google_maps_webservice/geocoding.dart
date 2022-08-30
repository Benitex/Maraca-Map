import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';

class Geocoding {
  static final GoogleMapsGeocoding _api = GoogleMapsGeocoding(
    apiKey: FlutterConfig.get('MAPS_WEBSERVICES_API_KEY'),
  );

  /// Retorna uma lista de [GeocodingResult] presentes em uma [position] do mapa.
  static Future<List<GeocodingResult>> searchByLocation(LatLng position) async {
    GeocodingResponse response = await _api.searchByLocation(
      Location(lat: position.latitude, lng: position.longitude),
    );

    return response.results;
  }
}
