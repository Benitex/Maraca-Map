import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trabalho_final/apis.dart';

class PointOfInterest {
  PointOfInterest(this._id);

  late PlaceDetails _placesDetails;

  final String _id;
  late String _name, _address;
  late List<String> _types;
  String _iconAdress = "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png";

  Future<PlaceDetails> getDetails() async {
    PlacesDetailsResponse details = await API.places.getDetailsByPlaceId(_id, language: "pt-BR");
    _placesDetails = details.result;

    _name = _placesDetails.name;
    _types = _placesDetails.types;

    // Ícone
    if (_placesDetails.icon is String) {
      _iconAdress = _placesDetails.icon!;
    }

    // Endereço
    List<AddressComponent> adressComponents = _placesDetails.addressComponents;
    // AddressComponent[1] = rua, AddressComponent[0] = número
    _address = "${adressComponents[1].shortName}, ${adressComponents[0].shortName}";

    // TODO definir os outros atributos de acordo com os details

    return _placesDetails;
  }

  String get name => _name;
  String get address => _address;
  Image get icon => Image.network(_iconAdress, color: Colors.white, width: 30);
}
