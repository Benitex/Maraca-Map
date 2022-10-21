import 'package:flutter/material.dart';
import 'package:maraca_map/models/option.dart';
import 'package:maraca_map/services/local_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.updateMap});

  final Function updateMap;

  static Option darkMode = Option(
    name: "Modo escuro",
    description: "Muda o esquema de cores para uma versão mais escura.",
    active: false,
  );

  static Option satelliteMap = Option(
    name: "Mapa de satélite",
    description: "Quando ativo, muda a exibição do mapa para imagens de satélite. Pode utilizar mais internet e alguns ícones podem ficar indisponíveis.",
    active: false,
  );

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for (Option option in [SettingsScreen.darkMode, SettingsScreen.satelliteMap])
            Card(child: SwitchListTile(
              title: Text(option.name),
              subtitle: Text(option.description),
              isThreeLine: true,
              value: option.active,
              onChanged: (value) async {
                option.active = value;
                await LocalStorage.saveOption(option);
                setState(() => widget.updateMap());
              },
            )),
        ],
      ),
    );
  }
}
