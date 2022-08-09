import 'package:flutter/material.dart';
import 'package:trabalho_final/providers/types.dart';
import 'package:trabalho_final/screens/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Types.loadJSONMap();
  runApp(const MaracaMap());
}

class MaracaMap extends StatelessWidget {
  const MaracaMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Map(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0x00012030),
      ),
    );
  }
}
