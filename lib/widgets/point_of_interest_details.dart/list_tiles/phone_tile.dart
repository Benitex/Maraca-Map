import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneTile extends StatelessWidget {
  const PhoneTile({super.key, required this.phoneNumber});

  final Map<String, String> phoneNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Telefone"),
      subtitle: Row(children: [
        Text(
          phoneNumber["phone_number"]! == '' ? (
            "Número de telefone indisponível."
          ) : (
            phoneNumber["phone_number"]!
          ),
        ),
        const Spacer(),

        Tooltip(
          message: "Ligar",
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            onPressed: () async {
              await launchUrl(Uri(
                scheme: "tel",
                path: "${phoneNumber['formatted_phone_number']}",
              ));
            },
            child: const Icon(Icons.phone),
          ),
        ),
      ]),
    );
  }
}
