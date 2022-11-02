class Option {
  Option({required this.name, required this.description, required this.active});

  final String name, description;
  bool active;

  Option copyWith(bool value) {
    return Option(name: name, description: description, active: value);
  }
}
