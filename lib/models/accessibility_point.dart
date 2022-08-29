import 'package:google_maps_flutter/google_maps_flutter.dart';

class AccessibilityMarker extends Marker {
  AccessibilityMarker({
    required MarkerId id,
    required LatLng position,
    required type,
  }) : super(
    markerId: id,
    position: position,
    infoWindow: InfoWindow(title: type),
    icon: BitmapDescriptor.defaultMarker, // TODO adicionar icons customizados
  );
}
