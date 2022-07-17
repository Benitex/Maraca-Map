import 'package:flutter/material.dart';
import 'package:trabalho_final/screens/map_screen.dart';
import 'package:trabalho_final/classes/themes.dart';

void main() => runApp(const ProjetoFinal());

// TODO adidicionar o nome do aplicativo
class ProjetoFinal extends StatelessWidget {
  const ProjetoFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MapScreen(),
      theme: Themes.standard,
      debugShowCheckedModeBanner: false,
    );
  }
}
