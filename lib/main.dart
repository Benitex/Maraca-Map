import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maraca_map/models/accessibility_marker.dart';
import 'package:maraca_map/screens/filter_selection.dart';
import 'package:maraca_map/services/local_storage.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/services/firebase/firestore.dart';
import 'package:maraca_map/services/firebase/firebase_options.dart';
import 'package:maraca_map/screens/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.loadSettingsValues();
  FilterSelectionScreen.filters = await Firestore.getFilters();
  await AccessibilityMarker.loadIcons();
  MapScreen.accessibilityPoints = await Firestore.getAccessibilityPoints();

  runApp(const MaracaMap());
}

class MaracaMap extends StatefulWidget {
  const MaracaMap({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MaracaMap> createState() => _MaracaMapState();
}

class _MaracaMapState extends State<MaracaMap> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(updateTheme: () => setState(() {})),
      navigatorKey: MaracaMap.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: SettingsScreen.darkMode.active ?
          DarkTheme.screensStyle : LightTheme.screensStyle,
    );
  }
}
