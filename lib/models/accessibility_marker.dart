import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AccessibilityMarker extends Marker {
  AccessibilityMarker({
    required MarkerId id,
    required LatLng position,
    required String type,
  }) : super(
    markerId: id,
    position: position,
    infoWindow: InfoWindow(title: type),
    icon: type == "Falta de calçada" ? _icons["missing_sidewalk"]!
        : type == "Falta de faixa de pedestre" ? _icons["missing_crosswalk"]!
        : type == "Falta de rampa" ? _icons["missing_ramp"]!
        : type == "Obstáculos na calçada" ? _icons["obstacle_on_the_sidewalk"]!
        : type == "Rampa de acesso" ? _icons["accessibility_ramp"]!
        : BitmapDescriptor.defaultMarker,
  );

  static const List<String> _markerAssets = [
    "accessibility_ramp",
    "missing_crosswalk",
    "missing_ramp",
    "missing_sidewalk",
    "obstacle_on_the_sidewalk",
  ];

  static final Map<String, BitmapDescriptor> _icons = {
    "": BitmapDescriptor.defaultMarker,
  };

  static loadIcons() async {
    for (String type in _markerAssets) {
      _icons[type] = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/custom_markers/$type.png",
      );
    }
  }
}
