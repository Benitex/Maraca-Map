import 'package:flutter/material.dart';
import 'package:trabalho_final/pages/map.dart';

void main() => runApp(const ProjetoFinal());

// TODO adidicionar o nome do aplicativo
class ProjetoFinal extends StatelessWidget {
  const ProjetoFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Map(),
    );
  }
}
