import 'package:maraca_map/models/option.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maraca_map/models/filter.dart';
import 'package:maraca_map/screens/settings.dart';

class LocalStorage {
  static Future<void> loadFilterValues(Map<String, Filter> filters) async {
    final SharedPreferences api = await SharedPreferences.getInstance();

    filters.forEach((key, filter) {
      if (api.getBool(key) is bool) {
        filter.active = api.getBool(key)!;
      }
    });
  }

  static Future<void> saveFilter(Filter filter) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setBool(filter.id, filter.active);
  }

  static Future<void> loadSettingsValues() async {
    final SharedPreferences api = await SharedPreferences.getInstance();

    if (api.getBool("Mapa de satélite") is bool) {
      SettingsScreen.satelliteMap.active = api.getBool("Mapa de satélite")!;
    }
    if (api.getBool("Modo escuro") is bool) {
      SettingsScreen.darkMode.active = api.getBool("Modo escuro")!;
    }
  }

  static Future<void> saveOption(Option option) async {
    final SharedPreferences api = await SharedPreferences.getInstance();
    await api.setBool(option.name, option.active);
  }
}
