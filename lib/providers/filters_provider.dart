import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/models/map_filter.dart';

final mapFiltersProvider = NotifierProvider<MapFiltersNotifier, Map<String, MapFilter>>(MapFiltersNotifier.new);

class MapFiltersNotifier extends Notifier<Map<String, MapFilter>> {
  @override
  Map<String, MapFilter> build() => {};

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
