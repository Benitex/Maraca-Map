import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/cloud_functions/google_maps_webservice/geolocator.dart';

class Places {
  static const String _webAPIKey = "AIzaSyDGEN_ctKKkqaA0jtx6n7f1WH0y6KohfuI";
  static final GoogleMapsPlaces _api = GoogleMapsPlaces(apiKey: _webAPIKey);

  static Future<PlaceDetails> getDetailsByPlaceId(String id) async {
    PlacesDetailsResponse response = await _api.getDetailsByPlaceId(id, language: "pt-BR");

    return response.result;
  }

  static Image getImageFromPhoto(Photo photo) {
    return Image.network(
      _api.buildPhotoUrl(
        photoReference: photo.photoReference,
        maxWidth: photo.width as int,
        maxHeight: photo.height as int,
      ),
    );
  }

  static Future<List<PlacesSearchResult>> nearbySearch({String type = '', num radius = 1000, PriceLevel maxprice = PriceLevel.veryExpensive}) async {
    LatLng location = await Geolocator.getCurrentLatLng();

    PlacesSearchResponse response = await _api.searchNearbyWithRadius(
      Location(lat: location.latitude, lng: location.longitude),
      radius,
      keyword: type == '' ? null : type,
      maxprice: maxprice == PriceLevel.veryExpensive ? null : maxprice,
    );

    return response.results;
  }
}
