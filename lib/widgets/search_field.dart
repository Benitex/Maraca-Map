import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:maraca_map/services/google_maps_webservice/places.dart';
import 'package:maraca_map/screens/point_of_interest_details.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: RawAutocomplete<Prediction>(
          textEditingController: controller,
          focusNode: FocusNode(),

          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.streetAddress,

              focusNode: focusNode,
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),

              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,

                hintStyle: TextStyle(color: Colors.black),
                hintText: "Busque endereços, estabelecimentos, tipos de lugares...",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            );
          },

          displayStringForOption: (Prediction option) => option.description!,
          optionsBuilder: (textEditingValue) async {
            if (textEditingValue.text == '') {
              return const Iterable<Prediction>.empty();
            }
            return await Places.autocomplete(textEditingValue.text);
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: FractionallySizedBox(
                  widthFactor: 0.9, heightFactor: 0.3,
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final Prediction option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () => onSelected(option),
                        child: ListTile(title: Text(option.description!)),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          onSelected: (Prediction option) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return PointOfInterestDetailsScreen(
                  pointOfInterestID: option.placeId!,
                );
              }),
            );
          },
        ),
      ),
    ]);
  }
}
