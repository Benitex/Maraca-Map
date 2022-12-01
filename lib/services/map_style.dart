import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/filters_provider.dart';
import 'package:maraca_map/providers/settings_provider.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';

final mapStyleConversorProvider = Provider<MapStyleConversor>((ref) {
  return MapStyleConversor(ref);
});

class MapStyleConversor {
  MapStyleConversor(this.ref);

  ProviderRef ref;

  /// Converte os [MapFilter] da [MapFilterSelectionScreen] em JSON
  String toJSON() {
    bool darkTheme = ref.read(settingsProvider)["darkMode"]!.active;
    final filters = ref.read(mapFiltersProvider);

    return '''
[
  ${darkTheme ? DarkTheme.mapStyle : LightTheme.mapStyle}
  {
    "featureType": "poi",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.attraction",
    "stylers": [
      {
        "visibility": "${filters["attractions"]!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "${filters["business"]!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.government",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "poi.medical",
    "stylers": [
      {
        "visibility": "${filters["medical"]!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "stylers": [{ "visibility": "on" }]
  },
  {
    "featureType": "poi.place_of_worship",
    "stylers": [
      {
        "visibility": "${filters["placesOfWorship"]!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.school",
    "stylers": [
      {
        "visibility": "${filters["schools"]!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.sports_complex",
    "stylers": [{ "visibility": "on" }]
  },
  {
    "featureType": "transit",
    "stylers": [{ "visibility": "off" }]
  },
  {
    "featureType": "transit.line",
    "stylers": [{ "visibility": "on" }]
  },
  {
    "featureType": "transit.station",
    "stylers": [
      {
        "visibility": "${filters["publicTransportStations"]!.active ? 'on' : 'off'}"
      }
    ]
  },
]
    ''';
  }
}
