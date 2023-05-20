import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:maraca_map/screens/general_screens.dart';
import 'package:maraca_map/services/geolocator.dart';
import 'package:maraca_map/models/point_of_interest_type.dart';
import 'package:maraca_map/widgets/explore/distance_form_field.dart';
import 'package:maraca_map/widgets/explore/points_of_interest_results_row.dart';
import 'package:maraca_map/widgets/explore/price_dropdown_menu.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({
    super.key,
    this.types = const [
      PointOfInterestType(
        id: "food",
        name: "Restaurantes",
        subtypes: [
          PointOfInterestType(id: "restaurant", name: "Restaurante"),
          PointOfInterestType(id: "snack bar", name: "Lanchonete"),
          PointOfInterestType(id: "fast food", name: "Fast Food"),
          PointOfInterestType(id: "vegan food", name: "Comida vegana"),
          PointOfInterestType(id: "bar", name: "Bar"),
          PointOfInterestType(id: "bakery", name: "Padaria"),
          PointOfInterestType(id: "cafe", name: "Café"),
          PointOfInterestType(id: "pizza", name: "Pizzaria"),
          PointOfInterestType(id: "steakhouse", name: "Churrascaria"),
          PointOfInterestType(id: "seafood", name: "Frutos do mar"),
          PointOfInterestType(id: "japanese food", name: "Comida japonesa"),
          PointOfInterestType(id: "mexican food", name: "Comida mexicana"),
          PointOfInterestType(id: "italian food", name: "Comida italiana"),
        ],
      ),
      PointOfInterestType(
        id: "store",
        name: "Lojas",
        subtypes: [
          PointOfInterestType(id: "shopping mall", name: "Shopping"),
          PointOfInterestType(id: "supermarket", name: "Supermercado"),
          PointOfInterestType(id: "convenience store", name: "Loja de conveniência"),
          PointOfInterestType(id: "bank", name: "Banco"),
          PointOfInterestType(id: "clothing store", name: "Loja de roupas"),
          PointOfInterestType(id: "beauty salon", name: "Salão de beleza"),
          PointOfInterestType(id: "jewelry store", name: "Loja de joias"),
          PointOfInterestType(id: "cash machine", name: "Caixa Eletrônico"),
          PointOfInterestType(id: "car dealer", name: "Concencionário de automóveis"),
          PointOfInterestType(id: "gas station", name: "Posto de gasolina"),
          PointOfInterestType(id: "electronics store", name: "Loja de eletrônicos"),
          PointOfInterestType(id: "hardware store", name: "Loja de ferramentas"),
          PointOfInterestType(id: "stationary store", name: "Papelaria"),
          PointOfInterestType(id: "laundry", name: "Lavanderia"),
          PointOfInterestType(id: "home goods store", name: "Loja de móveis"),
        ],
      ),
      PointOfInterestType(
        id: "transport",
        name: "Transporte público",
        subtypes: [
          PointOfInterestType(id: "bus station", name: "Ponto de ônibus"),
          PointOfInterestType(id: "subway station", name: "Estação de metrô"),
          PointOfInterestType(id: "train station", name: "Estação de trem"),
          PointOfInterestType(id: "airport", name: "Aeroporto"),
        ],
      ),
      PointOfInterestType(
        id: "school",
        name: "Escolas",
        subtypes: [
          PointOfInterestType(id: "primary school", name: "Escola de ensino fundamental"),
          PointOfInterestType(id: "secondary school", name: "Escola de ensino médio"),
          PointOfInterestType(id: "university", name: "Universidade"),
        ],
      ),
      PointOfInterestType(
        id: "attraction",
        name: "Lazer e turismo",
        subtypes: [
          PointOfInterestType(id: "park", name: "Parque"),
          PointOfInterestType(id: "tourist attraction", name: "Atração turística"),
          PointOfInterestType(id: "movie theater", name: "Cinema"),
          PointOfInterestType(id: "museum", name: "Museu"),
          PointOfInterestType(id: "amusement park", name: "Parque de diversões"),
          PointOfInterestType(id: "stadium", name: "Estádio"),
        ],
      ),
      PointOfInterestType(
        id: "medical",
        name: "Hospitais",
        subtypes: [
          PointOfInterestType(id: "hospital", name: "Hospital"),
          PointOfInterestType(id: "doctor", name: "Médico"),
          PointOfInterestType(id: "drugstore", name: "Farmácia"),
          PointOfInterestType(id: "veterinary care", name: "Veterinário"),
        ],
      ),
      PointOfInterestType(
        id: "place of worship",
        name: "Templos religiosos",
        subtypes: [
          PointOfInterestType(id: "catholic church", name: "Igreja católica"),
          PointOfInterestType(id: "evangelical church", name: "Igreja evangélica"),
          PointOfInterestType(id: "spiritist center", name: "Centro espírita"),
          PointOfInterestType(id: "cemetery", name: "Cemitério"),
        ],
      ),
    ],
  });

  final List<PointOfInterestType> types;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorar"),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Text("Distância média: ", style: TextStyle(color: Colors.white)),
              DistanceFormField(),
              Text("m", style: TextStyle(color: Colors.white)),
              Spacer(),
              Text("Preço: ", style: TextStyle(color: Colors.white)),
              PriceDropdownMenu(),
            ]),
          ),
        ),
      ),

      body: FutureBuilder(
        future: Future<Location>(() async => await Geolocator.getCurrentLocation()),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return ErrorScreen(error: snapshot.error!);

          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (PointOfInterestType type in types)
                  PointOfInterestResultsRow(
                    location: snapshot.data!,
                    typeName: type.name,
                    searchFor: type.name,
                    subtypes: type.subtypes,
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
