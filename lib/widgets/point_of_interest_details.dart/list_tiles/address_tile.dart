import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/screens/explore.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/services/google_maps_webservice/distance.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.location, this.address});

  final Location? location;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      location == null ? Container() : ListTile(
        title: Row(children: [
          const Text("Endereço"),
          const Spacer(),

          Tooltip(
            message: "Explorar lugares próximos",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const ExploreScreen();
                }),
              ),
              child: const Icon(Icons.share_location),
            ),
          ),
          Tooltip(
            message: "Mostrar no mapa",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
              onPressed: () async {
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );
                await MapScreen.moveCamera(
                  location: LatLng(location!.lat, location!.lng),
                  zoom: 20,
                );
              },
              child: const Icon(Icons.location_searching),
            ),
          ),
        ]),

        subtitle: Text(address == null ? "Endereço indisponível." : address!),
      ),
      FutureBuilder(
        future: Future(() async {
          if (location == null) return null;
          final distance = await Distance.fromHereTo(location!);
          return "Esse lugar está a ${distance.distance.text} de você. O tempo médio para chegar até lá é de ${distance.duration.text}.";
        }),
        builder: (context, snapshot) {
          return ListTile(subtitle: Text(
            snapshot.data ?? "Não foi possível calcular a distância até você.",
          ));
        },
      ),
    ]);
  }
}
