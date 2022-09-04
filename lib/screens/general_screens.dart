import 'package:flutter/material.dart';
import 'package:maraca_map/screens/settings.dart';
import 'package:maraca_map/themes/dark_theme.dart';
import 'package:maraca_map/themes/light_theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            color: SettingsScreen.options["Modo escuro"]!.active ?
              DarkTheme.primaryColor : LightTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: Text("Ocorreu um erro no carregamento da página.\nTente novamente mais tarde.")),
      ],
    );
  }
}

class NoResults extends StatelessWidget {
  const NoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: Text("Nenhum resultado encontrado.")),
      ],
    );
  }
}
