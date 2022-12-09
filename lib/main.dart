import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maraca_map/models/accessibility_marker.dart';
import 'package:maraca_map/providers/settings_provider.dart';
import 'package:maraca_map/services/local_storage.dart';
import 'package:maraca_map/services/firebase/firestore.dart';
import 'package:maraca_map/services/firebase/firebase_options.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AccessibilityMarker.loadIcons();

  runApp(ProviderScope(
    child: Consumer(
      builder: (context, ref, child) => FutureBuilder(
        future: Future(() async {
          final localStorage = ref.read(localStorageProvider);
          final firestore = ref.read(firestoreProvider);

          await localStorage.loadSettingsValues();
          await firestore.loadMapFilters();
          await localStorage.loadMapFiltersValues();
          await localStorage.loadPointOfInterestIdsLists();
          MapScreen.accessibilityPoints = await firestore.getAccessibilityPoints();
        }),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const MaracaMap();
          }
          return Container();
        }
      ),
    ),
  ));
}

class MaracaMap extends ConsumerWidget {
  const MaracaMap({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp(
      home: const MapScreen(),
      navigatorKey: MaracaMap.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: settings["darkMode"]!.active ? DarkTheme.screensStyle : LightTheme.screensStyle,
    );
  }
}
