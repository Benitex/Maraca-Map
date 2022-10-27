import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/distance.dart' as distance_api;
import 'package:maraca_map/screens/explore.dart';
import 'package:maraca_map/screens/map.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, required this.location, this.address, this.distance});

  final Location? location;
  final String? address;
  final distance_api.Element? distance;

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
                  return ExploreScreen(location: location!);
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
      ListTile(subtitle: Text(
        distance == null ? (
          "Não foi possível calcular a distância até você."
        ) : (
          "Esse lugar está a ${distance!.distance.text} de você. O tempo para chegar até lá a pé é de ${distance!.duration.text}."
        )
      )),
    ]);
  }
}
