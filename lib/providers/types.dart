import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trabalho_final/models/filter_option.dart';

class Types {
  static Future<List<FilterOption>> getFilterOptions() async {
    List<FilterOption> filterOptions = [];

    final Map data = await jsonDecode(
      await rootBundle.loadString(
        'assets/point_of_interest_types.json'
      ),
    );

    data.forEach((key, value) {
      filterOptions.add(
        FilterOption(key, value["initial_value"], value["portuguese_name"])
      );
    });

    return filterOptions;
  }
}
