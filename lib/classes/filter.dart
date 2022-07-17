// Classe Filter contendo as especificações de filtros do mapa para um usuário

class Filter {
  static final List<FilterOption> _options = [
    FilterOption('attractions', true),
    FilterOption('business', true),
    FilterOption('medical', false),
    FilterOption('placesOfWorship', false),
    FilterOption('schools', true),
    FilterOption('publicTransportStations', true),
    FilterOption('accessibility', false),
  ];

  static List<FilterOption> get options => _options;

  // Método que retorna uma String json equivalente ao filtro especificado
  static String getJSON() {
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
        "visibility": "${_getActivityString('attractions')}"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "${_getActivityString('business')}"
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
        "visibility": "${_getActivityString('medical')}"
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
        "visibility": "${_getActivityString('placesOfWorship')}"
      }
    ]
  },
  {
    "featureType": "poi.school",
    "stylers": [
      {
        "visibility": "${_getActivityString('schools')}"
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
        "visibility": "${_getActivityString('publicTransportStations')}"
      }
    ]
  },
]
    ''';
  }

  static String _getActivityString(String type) {
    for (var option in options) {
      if (type == option._type) {
        if (option.active) {
          return 'on';
        } else {
          return 'off';
        }
      }
    }
    return 'Error: Option not defined';
  }
}

class FilterOption {
  FilterOption(this._type, this.active);

  final String _type;
  bool active;

  String get type {
    switch (_type) {
      case 'attractions':
        return 'Passeios turísticos';
      case 'business':
        return 'Lojas e restaurantes';
      case 'medical':
        return 'Hospitais';
      case 'placesOfWorship':
        return 'Instituições religiosas';
      case 'schools':
        return 'Escolas';
      case 'publicTransportStations':
        return 'Transporte público';
      case 'accessibility':
        return 'Modo de acessibilidade';
      default:
        return 'Error: Option not defined';
    }
  }
}
