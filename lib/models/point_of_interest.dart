import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/distance.dart' as distance_api;
import 'package:maraca_map/services/google_maps_webservice/distance.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/map.dart';
import 'package:maraca_map/screens/settings.dart';

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

  /// ID do Google Places
  String get id => _id;

  /// Coordenadas no mapa no formato [Location]
  Location get location => _placesDetails.geometry!.location;

  /// Nome
  String get name => _placesDetails.name;

  /// [List] de [String] que contém tipos do Google Places
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

    MapScreen.filters.forEach((key, filter) {
      for (var subtype in filter.subtypes) {
        if (subtype.id == type) {
          translatedName = subtype.name;
          break;
        }
      }
    });

    return translatedName;
  }

  /// Ícone que representa o tipo de lugar como [Image]
  Image get icon {
    String iconAddress = "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png";
    if (_placesDetails.icon is String) {
      iconAddress = _placesDetails.icon!;
    }

    return Image.network(
      iconAddress,
      color: SettingsScreen.options["Modo escuro"]!.active ? Colors.white : Colors.black,
      width: 30,
    );
  }

  /// [String] contendo o endereço no formato "rua, número", ou equivalentes
  /// 
  /// Retorna "Endereço indisponível" caso não hajam informações suficientes
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

  /// Classificação obtida pela média das avaliações dos usuários
  /// 
  /// Retorna [-1] caso não hajam informações suficientes
  num get rating {
    if (_placesDetails.rating is num) {
      return _placesDetails.rating!;
    } else {
      return -1;
    }
  }

  /// [List] de [Review] dos usuários
  List<Review> get reviews => _placesDetails.reviews;

  /// [PriceLevel] que representa o preço do lugar
  /// 
  /// Retorna false caso não hajam informações suficientes
  get priceLevel {
    if (_placesDetails.priceLevel is PriceLevel) {
      return _placesDetails.priceLevel!;
    } else {
      return false;
    }
  }

  /// [Map] de [String] contendo número de telefone internacional no campo "phone_number" e formatado para ligação no campo "formatted_phone_number
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
    }

    return phoneNumber;
  }

  /// [Uri] para página do Google Places
  Uri get url => Uri.parse(_placesDetails.url!);

  /// Horário de funcionamento no formato [List], onde o campo 0 contém o horário de abertura e 1 o horário de fechamento
  /// 
  /// Retorna uma [List] contendo "Esse lugar não abre hoje." se o lugar não abrir no dia e "Horário de funcionamento indisponível." caso não hajam informações suficientes
  List<String> get openingHoursToday {
    if (_placesDetails.openingHours is OpeningHoursDetail) {
      int weekday = DateTime.now().weekday;

      // Conversão para o formato de List
      if (weekday > 6) {
        weekday = 0;  // Domingo é o dia 0, em vez de 7
      }

      if (_placesDetails.openingHours!.periods.length > weekday) {
        final OpeningHoursPeriod openingHoursPeriod = _placesDetails.openingHours!.periods[weekday];

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

  /// [List] de [Photo] do Google Places convertidas em [Image]
  List<Image> get images {
    List<Image> images = [];

    for (Photo photo in _placesDetails.photos) {
      images.add(
        Places.getImageFromPhoto(photo),
      );
    }

    return images;
  }

  /// [Element] contendo a distância até o usuário em tempo e quilômetros
  /// 
  /// Retorna [false] caso ocorra um erro
  get distance {
    if (_distanceFromUser != null) {
      return _distanceFromUser!;
    } else {
      return false;
    }
  }
}
