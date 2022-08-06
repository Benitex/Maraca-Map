import 'package:flutter/material.dart';
import 'package:trabalho_final/providers/types.dart';
import 'package:trabalho_final/screens/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Types.loadJSONMap();
  runApp(const ProjetoFinal());
}

// TODO adidicionar o nome do aplicativo
class ProjetoFinal extends StatelessWidget {
  const ProjetoFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Map(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0x00012030),
      ),
    );
  }
}
