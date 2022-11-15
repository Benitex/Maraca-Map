import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/models/filter.dart';

final mapFiltersProvider = StateNotifierProvider<MapFiltersNotifier, Map<String, MapFilter>>(
  (ref) => MapFiltersNotifier(),
);

class MapFiltersNotifier extends StateNotifier<Map<String, MapFilter>> {
  MapFiltersNotifier() : super({});

  void setFilters(Map<String, MapFilter> filters) => state = filters;

  void updateFilter(String filterID, bool value) {
    Map<String, MapFilter> newState = {};
    state.forEach((key, filter) {
      if (key == filterID) {
        newState[key] = filter.copyWith(value);
      } else {
        newState[key] = filter;
      }
    });
    state = newState;
  }
}
