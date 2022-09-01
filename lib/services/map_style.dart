import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';

class MapStyle {
  /// Tranforma uma lista de opções de filtro em JSON.
  static String toJSON(Map<String, Filter> filters) {
    bool darkTheme = SettingsScreen.options["Modo escuro"]!.active;
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
        "visibility": "${filters['attractions']!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "${filters['business']!.active ? 'on' : 'off'}"
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
        "visibility": "${filters['medical']!.active ? 'on' : 'off'}"
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
        "visibility": "${filters['placesOfWorship']!.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.school",
    "stylers": [
      {
        "visibility": "${filters['schools']!.active ? 'on' : 'off'}"
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
        "visibility": "${filters['publicTransportStations']!.active ? 'on' : 'off'}"
      }
    ]
  },
]
    ''';
  }
}
