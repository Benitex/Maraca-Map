import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/distance.dart' as distance_api;
import 'package:maraca_map/services/google_maps_webservice/distance.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/map.dart' as map_page;

class PointOfInterest {
  PointOfInterest(this._id);
  Future<void> setPlaceDetails() async {
    _placesDetails = await Places.getDetailsByPlaceId(_id);
    try {
      _distanceFromUser = await Distance.fromHereTo(location);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final String _id;
  late final PlaceDetails _placesDetails;
  distance_api.Element? _distanceFromUser;

  // ID
  String get id => _id;

  // Location
  get location {
    if (_placesDetails.geometry is Geometry) {
      return _placesDetails.geometry!.location;
    }
  }

  // Nome
  String get name => _placesDetails.name;

  // Tipos
  List<String> get types {
    List<String> types = [];
    for (String type in _placesDetails.types) {
      String name = _getTranslatedName(type);
      if (name != '') {
        // remoção de tipos genéricos se um tipo específicio foi definido
        if (name == "Estabelecimento" || name == "Loja") {
          if (types.isEmpty) {
            types.add(name);
          }
        } else {
          types.add(name);
        }
      }
    }

    return types;
  }

  String _getTranslatedName(String type) {
    String translatedName = "";

    for (var filter in map_page.Map.filters) {
      for (var subtype in filter.subtypes) {
        if (subtype.id == type) {
          translatedName = subtype.name;
        }
      }

      if (translatedName != '') {
        break;
      }
    }

    return translatedName;
  }

  // Ícone
  Image get icon {
    String iconAddress = "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png";
    if (_placesDetails.icon is String) {
      iconAddress = _placesDetails.icon!;
    }

    return Image.network(
      iconAddress,
      color: Colors.white,
      width: 30,
    );
  }

  // Endereço
  String get address {
    List<AddressComponent> adressComponents = _placesDetails.addressComponents;
    // AddressComponent[1] = rua, AddressComponent[0] = número
    if (adressComponents.length > 1) {
      return "${adressComponents[1].shortName}, ${adressComponents[0].shortName}";
    } else if (adressComponents.isNotEmpty) {
      return adressComponents.first.shortName;
    } else {
      return "Endereço indisponível.";
    }
  }

  // Classificação
  num get rating {
    if (_placesDetails.rating is num) {
      return _placesDetails.rating!;
    } else {
      return -1;
    }
  }

  // Avaliações
  List<Review> get reviews {
    return _placesDetails.reviews;
  }

  // Preço
  String get priceLevel {
    if (_placesDetails.priceLevel is PriceLevel) {
      switch (_placesDetails.priceLevel!) {
        case PriceLevel.free:
          return "Grátis";
        case PriceLevel.inexpensive:
          return "Barato";
        case PriceLevel.moderate:
          return "Moderado";
        case PriceLevel.expensive:
          return "Caro";
        case PriceLevel.veryExpensive:
          return "Muito caro";
      }
    } else {
      return "Informações de preço indisponíveis.";
    }
  }

  // Telefone
  Map<String, String> get phoneNumber {
    Map<String, String> phoneNumber = {
      "phone_number": '',
      "formatted_phone_number": '',
    };

    if (_placesDetails.internationalPhoneNumber is String) {
      phoneNumber["phone_number"] = _placesDetails.internationalPhoneNumber!;
      if (_placesDetails.formattedPhoneNumber is String) {
        phoneNumber["formatted_phone_number"] = _placesDetails.formattedPhoneNumber!;
      }
    } else {
      phoneNumber["phone_number"] = "Número de telefone indisponível.";
    }

    return phoneNumber;
  }

  // Página do Google Places
  get url {
    if (_placesDetails.url is String) {
      return Uri.parse(_placesDetails.url!);
    } else {
      return "Página indisponível.";
    }
  }

  // Horário de funcionamento
  String get openingHoursToday {
    if (_placesDetails.openingHours is OpeningHoursDetail) {
      int weekday = DateTime.now().weekday;
      if (weekday > 6) {
        weekday = 0;
      }

      String openingHours = '', closingHours = '';
      if (_placesDetails.openingHours!.periods.length > weekday) {  
        final OpeningHoursPeriod openingHoursPeriod = _placesDetails.openingHours!.periods[weekday];

        if (openingHoursPeriod.open is OpeningHoursPeriodDate && openingHoursPeriod.close is OpeningHoursPeriodDate) {
          openingHours = "${openingHoursPeriod.open!.time.substring(0, 2)}:${openingHoursPeriod.open!.time.substring(2)}";
          closingHours = "${openingHoursPeriod.close!.time.substring(0, 2)}:${openingHoursPeriod.close!.time.substring(2)}";
        }
      }

      if (openingHours != '') {
        return "Abre às $openingHours e fecha às $closingHours.";
      } else {
        return "Esse lugar não abre hoje.";
      }
    } else {
      return "Horário de funcionamento indisponível.";
    }
  }

  // Imagens
  List<Image> get images {
    List<Image> images = [];

    for (Photo photo in _placesDetails.photos) {
      images.add(
        Places.getImageFromPhoto(photo),
      );
    }

    return images;
  }

  // Distância até o usuário
  String get distance {
    if (_distanceFromUser != null) {
      return "Esse lugar está a ${_distanceFromUser!.distance.text} de você. O tempo para chegar até lá a pé é de ${_distanceFromUser!.duration.text}.";
    } else {
      return "Não foi possível calcular a distância até você.";
    }
  }
}
