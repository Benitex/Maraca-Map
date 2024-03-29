import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/providers/filters_provider.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';

class PointOfInterest {
  PointOfInterest.fromPlaceDetails({required WidgetRef ref, required PlaceDetails placeDetails}) {
    id = placeDetails.placeId;
    name = placeDetails.name;
    location = placeDetails.geometry == null ? null : placeDetails.geometry!.location;
    types = _setTypes(placeDetails.types, ref);
    icon = Image.network(
      placeDetails.icon != null ? placeDetails.icon! : "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png",
      width: 30,
    );
    address = _setAddress(placeDetails.addressComponents);
    rating = placeDetails.rating;
    reviews = placeDetails.reviews;
    priceLevel = placeDetails.priceLevel;
    phoneNumber = {
      "phone_number": placeDetails.internationalPhoneNumber,
      "formatted_phone_number": placeDetails.formattedPhoneNumber,
    };
    if (placeDetails.url == null) {
      throw "url do point of interest não definido pelo Google";
    } else {
      url = Uri.parse(placeDetails.url!);
    }
    openingHoursToday = _setOpeningHours(placeDetails.openingHours);
    images = [
      for (Photo photo in placeDetails.photos)
        Places.getImageFromPhoto(photo)
    ];
  }

  /// ID do Google Places
  late final String id;

  /// Nome
  late final String name;

  /// Coordenadas no mapa no formato [Location]
  late final Location? location;

  /// [List] de [String] que contém tipos do Google Places em português
  late final List<String> types;

  /// Ícone que representa o tipo de lugar como [Image]
  late final Image icon;

  /// [String] contendo o endereço no formato "rua, número", ou equivalentes
  ///
  /// Retorna null caso não hajam informações suficientes
  late final String? address;

  /// Classificação obtida pela média das avaliações dos usuários
  ///
  /// Retorna null caso não hajam informações suficientes
  late final num? rating;

  /// [List] de [Review] dos usuários
  late final List<Review> reviews;

  /// [PriceLevel] que representa o preço do point of interest
  ///
  /// Retorna null caso não hajam informações suficientes
  late final PriceLevel? priceLevel;

  /// [Map] de [String] contendo número de telefone internacional no campo "phone_number" e formatado para ligação no campo "formatted_phone_number
  late final Map<String, String?> phoneNumber;

  /// [Uri] para página do Google Places
  late final Uri url;

  /// Horário de funcionamento no formato [List], onde o campo 0 contém o horário de abertura e 1 o horário de fechamento
  ///
  /// Retorna uma [List] contendo "Esse lugar não abre hoje." se o lugar não abrir no dia e "Horário de funcionamento indisponível." caso não hajam informações suficientes
  late final List<String> openingHoursToday;

  /// [List] de [Photo] do Google Places convertidas em [Image]
  late final List<Image> images;

  List<String> _setTypes(List<String> types, WidgetRef ref) {
    String getTranslatedName(String type) {
      for (var filter in ref.read(mapFiltersProvider).values) {
        for (var subtype in filter.subtypes) {
          if (subtype.id == type) {
            return subtype.name;
          }
        }
      }
      return '';
    }

    List<String> translatedNames = [];
    for (String type in types) {
      String name = getTranslatedName(type);
      if (name != '') {
        // remoção de tipos genéricos se um tipo específicio foi definido
        if (name == "Estabelecimento" || name == "Loja") {
          if (translatedNames.isEmpty) {
            translatedNames.add(name);
          }
        } else {
          translatedNames.add(name);
        }
      }
    }

    return translatedNames;
  }

  String? _setAddress(List<AddressComponent> addressComponents) {
    // AddressComponent[1] = rua, AddressComponent[0] = número
    if (addressComponents.length > 1) {
      return "${addressComponents[1].shortName}, ${addressComponents[0].shortName}";
    } else if (addressComponents.isNotEmpty) {
      return addressComponents.first.shortName;
    }
    return null;
  }

  List<String> _setOpeningHours(OpeningHoursDetail? openingHours) {
    if (openingHours is OpeningHoursDetail) {
      int weekday = DateTime.now().weekday;

      if (weekday > 6) weekday = 0;  // Domingo ocupa a posição 0 na lista placeDetails.openingHours!.periods
      if (openingHours.periods.length > weekday) {
        final OpeningHoursPeriod openingHoursPeriod = openingHours.periods[weekday];

        if (openingHoursPeriod.open is OpeningHoursPeriodDate && openingHoursPeriod.close is OpeningHoursPeriodDate) {
          return [
            "${openingHoursPeriod.open!.time.substring(0, 2)}:${openingHoursPeriod.open!.time.substring(2)}",
            "${openingHoursPeriod.close!.time.substring(0, 2)}:${openingHoursPeriod.close!.time.substring(2)}"
          ];
        }
      }

      return ["Esse lugar não abre hoje."];
    } else {
      return ["Horário de funcionamento indisponível."];
    }
  }
}
