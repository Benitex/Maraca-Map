import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as api;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Geolocator {
  /// Retorna a posição atual do usuário como [LatLng].
  static Future<LatLng> getCurrentLatLng() async {
    await _checkPermissions(); // TODO adicionar avisos de negação de permissões
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
      return Future.error("A localização por GPS está desativada.");
    }

    if (permission == LocationPermission.denied) {
      LocationPermission permission = await api.Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("A permissão de acesso à localização foi negada.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("A permissão de acesso à localização foi negada para sempre.");
    }
  }
}
