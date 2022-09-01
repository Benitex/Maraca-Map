import 'package:flutter/material.dart';
import 'package:maraca_map/models/option.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.updateMap});

  final Function updateMap;

  static final Map<String, Option> options = {
    "Mapa de satélite": Option(
      name: "Mapa de satélite",
      description: "",
      active: false,
    ),
    "Modo escuro": Option(
      name: "Modo escuro",
      description: "",
      active: false,
    ),
  };

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Option> _options = [];

  @override
  void initState() {
    _options.clear();
    Settings.options.forEach((key, option) {
      _options.add(option);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (Option option in _options)
            Card(child: SwitchListTile(
              title: Text(option.name),
              value: option.active,
              onChanged: (value) => setState(() {
                option.active = value;
                widget.updateMap();
              }),
            )),
        ],
      ),
    );
  }
}
