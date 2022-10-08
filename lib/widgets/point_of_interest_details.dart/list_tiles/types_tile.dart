import 'package:flutter/material.dart';

class TypesTile extends StatelessWidget {
  const TypesTile({super.key, required this.types, required this.icon});

  final List<String> types;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(children: [
        for (int typeCounter = 0; typeCounter < types.length ; typeCounter++)
          Text(
            types[typeCounter] + (
              typeCounter + 1 < types.length ? "," : "."
            ),
          ),
        const Spacer(),
        icon,
      ]),
    );
  }
}
