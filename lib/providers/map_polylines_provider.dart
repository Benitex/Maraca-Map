import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapPolylinesProvider = NotifierProvider<MapPolylinesNotifier, Set<Polyline>>(MapPolylinesNotifier.new);

class MapPolylinesNotifier extends Notifier<Set<Polyline>> {
  @override
  Set<Polyline> build() => {};

  void add(Polyline newPolyline) {
    state = {...state, newPolyline};
  }

  void clear() => state = {};
  bool isEmpty() => state.isEmpty;
}
