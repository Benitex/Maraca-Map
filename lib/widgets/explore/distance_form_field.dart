import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/explore_filters_provider.dart';

class DistanceFormField extends ConsumerWidget {
  const DistanceFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 50,
      child: Row(children: [Expanded(
        child: TextFormField(
          initialValue: "1000",
          keyboardType: TextInputType.number,

          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(border: InputBorder.none),

          onFieldSubmitted: (value) => ref.read(exploreFiltersProvider.notifier).setDistance(int.parse(value)),
        ),
      )]),
    );
  }
}
