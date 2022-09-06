import 'package:flutter/material.dart';

class LocationServiceErrorAlert extends StatelessWidget {
  const LocationServiceErrorAlert({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Erro ao receber localização"),
      content: Text("$text Algumas funções podem não funcionar corretamente sem esse serviço."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Ok", style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
