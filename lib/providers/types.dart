import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trabalho_final/models/filter_option.dart';

class Types {
  static late final Map _map;

  static Future loadJSONMap() async {
    _map = await jsonDecode(
      await rootBundle.loadString('assets/point_of_interest_types.json'),
    );
  }

  static List<FilterOption> getFilterOptions() {
    List<FilterOption> filterOptions = [];

    _map.forEach((key, type) {
      filterOptions.add(
        FilterOption(key, type["initial_value"], type["portuguese_name"]),
      );
    });

    return filterOptions;
  }

  static List<String> getSubtypesByName(String name) {
    List<String> subtypes = [];

    _map.forEach((key, type) {
      if (type['portuguese_name'] == name) {
        for (Map subtype in type['subtypes']) {
          subtypes.add(subtype['type']);
        }
      }
    });

    return subtypes;
  }

  static String getTranslatedName(String type) {
    String translatedName = '';

    _map.forEach((name, value) {
      for (Map subtype in value['subtypes']) {
        if (type == subtype["type"]) {
          translatedName = subtype['portuguese_name'];
        }
      }
    });

    return translatedName;
  }
}
