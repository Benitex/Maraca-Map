// Classe que fornece um JSON

import 'package:maraca_map/models/filter_option.dart';

class Filter {
  static late List<FilterOption> _filterOptions;

  static String _getActivity(String type) {
    FilterOption option = _filterOptions.firstWhere((option) => option.type == type);
    return (option.active ? 'on' : 'off');
  }

  static String getJSON(List<FilterOption> options) {
    _filterOptions = options;
    return '''
[
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
}
