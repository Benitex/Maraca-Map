import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_webservice/places.dart';

class Places {
  static final GoogleMapsPlaces _api = GoogleMapsPlaces(
    apiKey: FlutterConfig.get('MAPS_WEBSERVICES_API_KEY'),
  );

  static Future<PlaceDetails> getDetailsByPlaceId(String id) async {
    PlacesDetailsResponse response = await _api.getDetailsByPlaceId(id, language: "pt-BR");

    return response.result;
  }

  /// Transforma uma [Photo] em um [Widget] do tipo [Image].
  /// 
  /// A [Image] é criada a partir da sua [photoReference] com [Image.network].
  static Image getImageFromPhoto(Photo photo) {
    return Image.network(
      _api.buildPhotoUrl(
        photoReference: photo.photoReference,
        maxWidth: photo.width as int,
        maxHeight: photo.height as int,
      ),
    );
  }

  /// Utilizado para facilitar buscas por [PointOfInterest] realizando uma busca
  /// a partir do [text] e retornando uma [List] de [Prediction] com os resultados.
  static Future<List<Prediction>> autocomplete(String text) async {
    PlacesAutocompleteResponse response = await _api.autocomplete(text);
    return response.predictions;
  }

  /// Realiza uma busca por [PointOfInterest] a partir do [text] e retorna uma [List] de [PlacesSearchResult] com os resultados.
  static Future<List<PlacesSearchResult>> searchByText(String text) async {
    PlacesSearchResponse response = await _api.searchByText(text);
    return response.results;
  }

  /// Busca [PointOfInterest] próximos de uma [Location], retornando uma [List] de [PlacesSearchResult].
  /// 
  /// [type], e [maxprice] são os atributos do [PointOfInterest].
  /// 
  /// [radius] é a distância média máxima do usuário até o [PointOfInterest].
  static Future<List<PlacesSearchResult>> nearbySearch({
    required Location location,
    String? type,
    num radius = 1000,
    PriceLevel maxprice = PriceLevel.veryExpensive,
  }) async {
    PlacesSearchResponse response = await _api.searchNearbyWithRadius(
      location,
      radius,
      keyword: type,
      maxprice: maxprice == PriceLevel.veryExpensive ? null : maxprice,
    );

    return response.results;
  }
}
