import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/models/option.dart';
import 'package:maraca_map/providers/settings_provider.dart';
import 'package:maraca_map/services/local_storage.dart';

class OptionTile extends ConsumerWidget {
  const OptionTile({super.key, required this.option, this.function});

  final Option option;
  final Function? function;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsController = ref.watch(settingsProvider.notifier);
    final localStorage = ref.read(localStorageProvider);

    return Card(child: SwitchListTile(
      title: Text(option.name),
      subtitle: Text(option.description),
      isThreeLine: true,
      value: option.active,
      onChanged: (value) async {
        settingsController.updateOption(option.name, value);
        await localStorage.saveOption(option.name, value);
        if (function != null) function!();
      },
    ));
  }
}
