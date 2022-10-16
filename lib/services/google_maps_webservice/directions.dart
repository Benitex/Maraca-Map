import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as polyline_api;
import 'package:google_maps_webservice/directions.dart';
import 'package:maraca_map/services/geolocator.dart';

class Directions {
  static final GoogleMapsDirections _api = GoogleMapsDirections(
    apiKey: FlutterConfig.get('MAPS_WEBSERVICES_API_KEY'),
  );

  static Future<Route> getRouteToDestination({Location? origin, required Location destination}) async {
    origin ??= await Geolocator.getCurrentLocation();

    DirectionsResponse response = await _api.directionsWithLocation(
      origin,
      destination,
      travelMode: TravelMode.walking,
    );

    if (response.routes.isEmpty) {
      throw response.errorMessage!;
    } else {
      return response.routes.first;
    }
  }

  static List<LatLng> decodePolyline(String polyline) {
    List<LatLng> polylines = [];

    List<polyline_api.PointLatLng> result = polyline_api.PolylinePoints().decodePolyline(polyline);
    for (polyline_api.PointLatLng pointLatLng in result) {
      polylines.add(
        LatLng(pointLatLng.latitude, pointLatLng.longitude),
      );
    }

    return polylines;
  }
}
