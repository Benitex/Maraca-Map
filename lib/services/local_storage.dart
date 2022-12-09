import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maraca_map/providers/filters_provider.dart';
import 'package:maraca_map/providers/settings_provider.dart';
import 'package:maraca_map/providers/point_of_interest_lists_provider.dart';

final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorage(ref),
);

class LocalStorage {
  LocalStorage(this.ref);

  ProviderRef ref;

  /// Carrega os valores dos [MapFilter] armazenados no dispositivo para seu [NotifierProvider].
  Future<void> loadMapFiltersValues() async {
    final filters = ref.read(mapFiltersProvider);
    final filtersController = ref.read(mapFiltersProvider.notifier);
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

  /// Salva o valor de um [MapFilter] de com um determinado [filterName]
  Future<void> saveFilter(String filterID, bool value) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setBool(filterID, value);
  }

  /// Carrega os valores das [Option] armazenados no dispositivo para seu [NotifierProvider].
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

  /// Salva o [value] de uma [Option] de com uma determinada [optionName]
  Future<void> saveOption(String optionName, bool value) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setBool(optionName, value);
  }

  /// Carrega as listas de com ids de [PointOfInterest] para seu [NotifierProvider].
  Future<void> loadPointOfInterestIdsLists() async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    List<String>? lists = api.getStringList("listNames");

    if (lists is List<String>) {
      for (String listName in lists) {
        List<String>? ids = api.getStringList(listName);
        ref.read(pointOfInterestListProvider.notifier).addList(
          listName: listName,
          list: ids,
        );
      }
    }
  }

  /// Salva uma [List] de [ids] de [PointOfInterest] de acordo com seu [name].
  Future<void> savePointOfInterestIdsList(String name, List<String> ids) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setStringList(name, ids);
  }

  /// Salva os [names] das [List] de ids de [PointOfInterest].
  Future<void> saveListNames(List<String> names) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setStringList("listNames", names);
  }
}
