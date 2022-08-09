import 'package:flutter/material.dart';
import 'package:maraca_map/providers/types.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maraca_map/cloud_functions/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Types.loadJSONMap();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
