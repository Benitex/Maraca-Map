import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,

            hintStyle: TextStyle(color: Colors.black),
            hintText: "Busque endereços, estabelecimentos, tipos de lugares...",

            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            contentPadding: EdgeInsets.only(top: 5, bottom: 5)
          ),
          // TODO adicionar autocomplete
        ),
      ),
    ]);
  }
}
