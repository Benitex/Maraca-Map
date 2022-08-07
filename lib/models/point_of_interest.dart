import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trabalho_final/providers/places.dart';
import 'package:trabalho_final/providers/types.dart';

class PointOfInterest {
  PointOfInterest(this._id);
  Future setPlaceDetails() async {
    _placesDetails = await Places.getDetailsByPlaceId(_id);
    return true;
  }

  final String _id;
  late final PlaceDetails _placesDetails;

  // ID
  String get id => _id;

  // Nome
  String get name => _placesDetails.name;

  // Tipos
  List<String> get types {
    List<String> types = [];
    for (String type in _placesDetails.types) {
      String name = Types.getTranslatedName(type);
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
    return "${adressComponents[1].shortName}, ${adressComponents[0].shortName}";
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

      OpeningHoursPeriod openingHoursPeriod = _placesDetails.openingHours!.periods[weekday];
      String openingHours = '', closingHours = '';

      if (openingHoursPeriod.open is OpeningHoursPeriodDate && openingHoursPeriod.close is OpeningHoursPeriodDate) {
        openingHours = "${openingHoursPeriod.open!.time.substring(0, 2)}:${openingHoursPeriod.open!.time.substring(2)}";
        closingHours = "${openingHoursPeriod.close!.time.substring(0, 2)}:${openingHoursPeriod.close!.time.substring(2)}";
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
}
