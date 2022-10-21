import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';

class MapStyle {
  /// Converte os [Filter] da [FilterSelectionScreen] em JSON
  static String toJSON() {
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
        "visibility": "${FilterSelectionScreen.attractions.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "${FilterSelectionScreen.business.active ? 'on' : 'off'}"
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
        "visibility": "${FilterSelectionScreen.medical.active ? 'on' : 'off'}"
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
        "visibility": "${FilterSelectionScreen.placesOfWorship.active ? 'on' : 'off'}"
      }
    ]
  },
  {
    "featureType": "poi.school",
    "stylers": [
      {
        "visibility": "${FilterSelectionScreen.schools.active ? 'on' : 'off'}"
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
        "visibility": "${FilterSelectionScreen.publicTransportStations.active ? 'on' : 'off'}"
      }
    ]
  },
]
    ''';
  }
}
