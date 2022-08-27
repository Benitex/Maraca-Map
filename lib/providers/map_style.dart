import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/settings.dart';

class MapStyle {
  static late List<Filter> _filters;

  // converte bools para formatação "on", "off"
  static String _getActivity(String type) {
    Filter filter = _filters.firstWhere((element) => element.type == type);
    return (filter.active ? 'on' : 'off');
  }

  // tranforma uma lista de opções de filtro em JSON
  static String getJSON(List<Filter> filters) {
    _filters = filters;
    bool darkTheme = Settings.options.firstWhere(
      (option) => option.name == "Modo escuro",
    ).active;
    return '''
[
  ${darkTheme ? _darkTheme : ''}
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

  static const String _darkTheme = '''
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
    ''';
}
