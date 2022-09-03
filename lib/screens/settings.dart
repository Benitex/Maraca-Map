import 'package:flutter/material.dart';
import 'package:maraca_map/models/option.dart';
import 'package:maraca_map/services/local_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.updateMap});

  final Function updateMap;

  static final Map<String, Option> options = {
    "Mapa de satélite": Option(
      name: "Mapa de satélite",
      description: "Quando ativo, muda a exibição do mapa para imagens de satélite. Pode utilizar mais internet e alguns ícones podem ficar indisponíveis.",
      active: false,
    ),
    "Modo escuro": Option(
      name: "Modo escuro",
      description: "Muda o esquema de cores para uma versão mais escura.",
      active: false,
    ),
  };

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Option> _options = [];

  @override
  void initState() {
    _options.clear();
    SettingsScreen.options.forEach((key, option) {
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
              subtitle: Text(option.description),
              isThreeLine: true,
              value: option.active,
              onChanged: (value) async {
                await LocalStorage.setOptionValue(option, value);
                setState(() => widget.updateMap());
              },
            )),
        ],
      ),
    );
  }
}
