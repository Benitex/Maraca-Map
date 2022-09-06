import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as api;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maraca_map/main.dart';
import 'package:maraca_map/widgets/location_service_error_alert.dart';

class Geolocator {
  /// Retorna a posição atual do usuário como [LatLng].
  static Future<LatLng> getCurrentLatLng() async {
    await _checkPermissions();
    Position position = await api.Geolocator.getCurrentPosition();

    return LatLng(
      position.latitude,
      position.longitude,
    );
  }

  /// Realiza as verificações das permissões de localização.
  static _checkPermissions() async {
    // Verificação se a localização por GPS está ativada
    bool gpsEnabled = await api.Geolocator.isLocationServiceEnabled();

    // Verificação se o usuário deu permissão de localização
    LocationPermission permission = await api.Geolocator.checkPermission();

    if (!gpsEnabled) {
      showDialog(
        context: MaracaMap.navigatorKey.currentContext!,
        builder: (context) => const LocationServiceErrorAlert(
          text: "A localização por GPS está desativada. Ative no painel de notificações do seu dispositivo.",
        ),
      );
      return Future.error("location service disabled");
    }

    if (permission == LocationPermission.denied) {
      LocationPermission permission = await api.Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: MaracaMap.navigatorKey.currentContext!,
          builder: (context) => const LocationServiceErrorAlert(
            text: "A localização por GPS está desativada. Para permitir, clique em permitir da próxima vez que for requisitado.",
          ),
        );
        return Future.error("location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: MaracaMap.navigatorKey.currentContext!,
        builder: (context) => const LocationServiceErrorAlert(
          text: "A permissão de acesso à localização foi negada para sempre. Para permitir, modifique as permissões no aplicativo de configurações do dispositivo.",
        ),
      );
      return Future.error("location permission denied forever");
    }
  }
}
