import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:maraca_map/providers/map_polylines_provider.dart';
import 'package:maraca_map/services/google_maps_webservice/directions.dart';

class RouteFloatingActionButton extends ConsumerWidget {
  const RouteFloatingActionButton({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      tooltip: "Mostrar rotas no mapa",
      onPressed: () async {
        try {
          var route = await Directions.getRouteToDestination(
            destination: location,
          );
          ref.read(mapPolylinesProvider.notifier).add(
            Polyline(
              polylineId: const PolylineId("polyline"),
              color: Colors.red,
              points: Directions.decodePolyline(
                route.overviewPolyline.points,
              ),
            ),
          );

          if (!context.mounted) return;
          Navigator.popUntil(context, (route) => route.isFirst);
          for (var warning in route.warnings) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(warning)),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ocorreu um erro no carregamento da rota. Tente novamente mais tarde.")),
          );
        }
      },
      child: const Icon(Icons.route),
    );
  }
}
