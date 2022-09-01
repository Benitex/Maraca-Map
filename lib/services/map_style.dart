import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';

class MapStyle {
  static late List<Filter> _filters;

  /// Tranforma uma lista de opções de filtro em JSON.
  static String getJSON(List<Filter> filters) {
    _filters = filters;
    bool darkTheme = Settings.options["Modo escuro"]!.active;
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
        "visibility": "${_getActivity('attractions')}"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "${_getActivity('business')}"
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
        "visibility": "${_getActivity('medical')}"
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
        "visibility": "${_getActivity('placesOfWorship')}"
      }
    ]
  },
  {
    "featureType": "poi.school",
    "stylers": [
      {
        "visibility": "${_getActivity('schools')}"
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
        "visibility": "${_getActivity('publicTransportStations')}"
      }
    ]
  },
]
    ''';
  }

  /// Converte bools para formatação "on", "off".
  static String _getActivity(String id) {
    Filter filter = _filters.firstWhere((element) => element.id == id);
    return (filter.active ? 'on' : 'off');
  }
}
