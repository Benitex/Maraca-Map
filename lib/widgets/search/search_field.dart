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
          // TODO adicionar autocomplete
        ),
      )
    ]);
  }
}
