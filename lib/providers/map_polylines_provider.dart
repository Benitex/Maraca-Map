import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapPolylinesProvider = StateNotifierProvider<MapPolylinesNotifier, Set<Polyline>>(
  (ref) => MapPolylinesNotifier(),
);

class MapPolylinesNotifier extends StateNotifier<Set<Polyline>> {
  MapPolylinesNotifier() : super({});

  void add(Polyline newPolyline) {
    state = {...state, newPolyline};
  }

  void clear() => state = {};

  bool isEmpty() => state.isEmpty;
}
