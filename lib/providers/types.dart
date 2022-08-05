import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trabalho_final/models/filter_option.dart';

class Types {
  static Future<List<FilterOption>> getFilterOptions() async {
    List<FilterOption> filterOptions = [];

    final Map types = await jsonDecode(
      await rootBundle.loadString('assets/point_of_interest_types.json'),
    );

    types.forEach((key, value) {
      filterOptions.add(
        FilterOption(key, value["initial_value"], value["portuguese_name"])
      );
    });

    return filterOptions;
  }

  static Future<List<String>> getSubtypesByName(String name) async {
    List<String> subtypes = [];

    final Map types = await jsonDecode(
      await rootBundle.loadString('assets/point_of_interest_types.json'),
    );

    types.forEach((key, type) {
      if (type['portuguese_name'] == name) {
        for (Map subtype in type['sub_types']) {
          subtypes.add(subtype['type']);
        }
      }
    });

    return subtypes;
  }
}
