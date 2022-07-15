// Classe Filter contendo as especificações de filtros do mapa para um usuário

//TODO aumentar a densidade dos poi

class Filter {
  static Map<String, String> _settings = {
    'attractions': 'on',
    'business': 'on', // TODO dividir o business
    'medical': 'on',
    'placesOfWorship': 'on',
    'schools': 'on',
    'publicTransportStations': 'on',
  };

  static set attractions(bool active) {
    _settings['attractions'] = active ? 'on' : 'off';
  }
  static set business(bool active) {
    _settings['business'] = active ? 'on' : 'off';
  }
  static set medical(bool active) {
    _settings['medical'] = active ? 'on' : 'off';
  }
  static set placesOfWorship(bool active) {
    _settings['placesOfWorship'] = active ? 'on' : 'off';
  }
  static set schools(bool active) {
    _settings['schools'] = active ? 'on' : 'off';
  }
  static set publicTransportStations(bool active) {
    _settings['publicTransportStations'] = active ? 'on' : 'off';
  }

  // Método que retorna uma String json equivalente ao filtro especificado
  static String get() {
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
        "visibility": "${_settings['attractions']}"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "${_settings['business']}"
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
        "visibility": "${_settings['medical']}"
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
        "visibility": "${_settings['placesOfWorship']}"
      }
    ]
  },
  {
    "featureType": "poi.school",
    "stylers": [
      {
        "visibility": "${_settings['schools']}"
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
        "visibility": "${_settings['publicTransportStations']}"
      }
    ]
  },
]
    ''';
  }
}
