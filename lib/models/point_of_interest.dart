import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trabalho_final/providers/places.dart';

class PointOfInterest {
  PointOfInterest(this._id);
  Future setPlaceDetails() async {
    _placesDetails = await Places.getDetailsByPlaceId(_id);
    return true;
  }

  final String _id;
  late PlaceDetails _placesDetails;

  // TODO definir os outros atributos de acordo com os details

  // ID
  String get id => _id;

  // Nome
  String get name => _placesDetails.name;

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
}