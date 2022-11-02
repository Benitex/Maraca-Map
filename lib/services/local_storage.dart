import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maraca_map/providers/filters_provider.dart';
import 'package:maraca_map/providers/settings_provider.dart';

final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorage(ref),
);

class LocalStorage {
  LocalStorage(this.ref);

  ProviderRef ref;

  /// Carrega os valores dos [Filter] armazenados no dispositivo para seu [StateNotifierProvider].
  Future<void> loadFilterValues() async {
    final filters = ref.read(filtersProvider);
    final filtersController = ref.read(filtersProvider.notifier);
    final SharedPreferences api = await SharedPreferences.getInstance();

    filters.forEach((key, filter) {
      if (api.getBool(filter.id) is bool) {
        filtersController.updateFilter(
          filter.id,
          api.getBool(filter.id)!,
        );
      }
    });
  }

  /// Salva o valor de um [Filter] de com um determinado [filterName]
  Future<void> saveFilter(String filterID, bool value) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setBool(filterID, value);
  }

  /// Carrega os valores das [Option] armazenados no dispositivo para seu [StateNotifierProvider].
  Future<void> loadSettingsValues() async {
    final settings = ref.read(settingsProvider);
    final settingsController = ref.read(settingsProvider.notifier);
    final SharedPreferences api = await SharedPreferences.getInstance();

    settings.forEach((key, option) {
      if (api.getBool(option.name) is bool) {
        settingsController.updateOption(
          option.name,
          api.getBool(option.name)!,
        );
      }
    });
  }

  /// Salva o valor de uma [Option] de com uma determinada [optionName]
  Future<void> saveOption(String optionName, bool value) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setBool(optionName, value);
  }
}
