import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/settings_provider.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/services/map_style.dart';
import 'package:maraca_map/widgets/settings/option_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          OptionTile(
            option: settings["darkMode"]!,
            function: () => MapScreen.controller.setMapStyle(
              ref.read(mapStyleConversorProvider).toJSON(),
            ),
          ),
          OptionTile(option: settings["satelliteMap"]!),
        ],
      ),
    );
  }
}
