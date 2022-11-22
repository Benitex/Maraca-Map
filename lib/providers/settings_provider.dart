import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/models/option.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, Map<String, Option>>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<Map<String, Option>> {
  @override
  Map<String, Option> build() => {
    "Modo escuro": Option(
      name: "Modo escuro",
      description: "Muda o esquema de cores para uma versão mais escura.",
      active: false,
    ),
    "Mapa de satélite": Option(
      name: "Mapa de satélite",
      description: "Quando ativo, muda a exibição do mapa para imagens de satélite. Pode utilizar mais internet e alguns ícones podem ficar indisponíveis.",
      active: false,
    ),
  };

  void updateOption(String optionName, bool value) {
    Map<String, Option> newState = {};
    state.forEach((name, option) {
      if (name == optionName) {
        newState[name] = option.copyWith(value);
      } else {
        newState[name] = option;
      }
    });
    state = newState;
  }
}
