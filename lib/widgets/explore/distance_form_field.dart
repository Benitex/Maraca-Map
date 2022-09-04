import 'package:flutter/material.dart';

class DistanceFormField extends StatelessWidget {
  const DistanceFormField({super.key});

  static final TextEditingController controller = TextEditingController(text: "1000");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Row(children: [Expanded(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
        ),
      )]),
    );
  }
}
