import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/models/filter.dart';

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<String, Filter>>(
  (ref) => FiltersNotifier(),
);

class FiltersNotifier extends StateNotifier<Map<String, Filter>> {
  FiltersNotifier() : super({});

  void setFilters(Map<String, Filter> filters) => state = filters;

  void updateFilter(String filterID, bool value) {
    Map<String, Filter> newState = {};
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
