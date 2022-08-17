import 'package:flutter/material.dart';
import 'package:maraca_map/models/option.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.updateMap});

  final Function updateMap;
  static final List<Option> options = [
    Option(name: "Mapa de satélite", active: false),
  ];

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (Option option in Settings.options)
            Card(
                child: SwitchListTile(
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
