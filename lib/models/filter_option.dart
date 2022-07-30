// Modelo de opções de filtro

class FilterOption {
  FilterOption(this._type, this.active);

  final String _type;
  bool active;

  String get type => _type;

  // Retorna o nome em português do tipo
  String get name {
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
