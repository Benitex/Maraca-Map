class Filter {
  Filter(this._type, this.active, this._name);

  final String _type, _name;
  bool active;

  String get type => _type;
  String get name => _name;
  // TODO adicionar campo description
}