import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_webservice/places.dart';

final exploreFiltersProvider = NotifierProvider<ExploreFiltersNotifier, Map<String, dynamic>>(ExploreFiltersNotifier.new);

class ExploreFiltersNotifier extends Notifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() => {
    "distance": 1000,
    "maxPrice": PriceLevel.veryExpensive,
  };

  void setMaxPrice(PriceLevel maxPrice) => _updateState(maxPrice: maxPrice);
  void setDistance(num distance) => _updateState(distance: distance);

  void _updateState({PriceLevel? maxPrice, num? distance}) {
    Map<String, dynamic> newState = {
      "maxPrice": maxPrice ?? state["maxPrice"],
      "distance": distance ?? state["distance"],
    };

    state = newState;
  }
}
