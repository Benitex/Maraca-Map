import 'package:maraca_map/models/option.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/models/filter.dart';

class LocalStorage {
  static Future<void> loadFilterValues() async {
    final SharedPreferences api = await SharedPreferences.getInstance();

    MapScreen.filters.forEach((key, filter) {
      if (api.getBool(key) is bool) {
        filter.active = api.getBool(key)!;
      }
    });
  }

  static Future<void> setFilterValue(Filter filter, bool value) async {
    final SharedPreferences api = await SharedPreferences.getInstance();

    filter.active = value;
    await api.setBool(filter.id, value);
  }

  static Future<void> loadSettingsValues() async {
    final SharedPreferences api = await SharedPreferences.getInstance();

    SettingsScreen.options.forEach((key, option) {
      if (api.getBool(key) is bool) {
        option.active = api.getBool(key)!;
      }
    });
  }

  static Future<void> setOptionValue(Option option, bool value) async {
    final SharedPreferences api = await SharedPreferences.getInstance();

    option.active = value;
    await api.setBool(option.name, value);
  }
}
