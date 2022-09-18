import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/models/type.dart';
import 'package:maraca_map/screens/map.dart';

class AccessibilityMarker extends Marker {
  AccessibilityMarker({
    required MarkerId id,
    required LatLng position,
    required type,
  }) : super(
    markerId: id,
    position: position,
    infoWindow: InfoWindow(title: type),
    icon: _icons[type]!,
  );

  static final Map<String, BitmapDescriptor> _icons = {
    "": BitmapDescriptor.defaultMarker,
  };

  static loadIcons() async {
    for (PointOfInterestType type in MapScreen.filters["accessibility"]!.subtypes) {
      _icons[type.name] = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/custom_markers/${type.id}.png",
      );
    }
  }
}
