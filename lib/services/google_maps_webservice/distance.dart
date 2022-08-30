import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/services/geolocator.dart';

class Distance {
  static final GoogleDistanceMatrix _api = GoogleDistanceMatrix(
    apiKey: FlutterConfig.get('MAPS_WEBSERVICES_API_KEY'),
  );

  /// Retorna um [Element], contendo [distance] e [duration].
  /// 
  /// Obtido a partir do cálculo da distância entre uma [destination] e a posição atual.
  static Future<Element> fromHereTo(Location destination) async {
    LatLng userLocation = await Geolocator.getCurrentLatLng();
    Location origin = Location(lat: userLocation.latitude, lng: userLocation.longitude);

    DistanceResponse response = await _api.distanceWithLocation(
      [origin], [destination],
      travelMode: TravelMode.walking,
    );

    if (response.rows.isEmpty) {
      throw response.errorMessage!;
    } else {
      return response.rows[0].elements[0];
    }
  }
}
