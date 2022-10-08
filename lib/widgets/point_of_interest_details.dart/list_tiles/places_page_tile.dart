import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesPageTile extends StatelessWidget {
  const PlacesPageTile({super.key, required this.url});

  final Uri url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Mais detalhes"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Conheça mais sobre esse lugar em sua página do Google Places:"),
          TextButton(
            onPressed: () async {
              if (!await launchUrl(url)) {
                throw "Could not launch $url";
              }
            },
            child: Text(
              url.toString(),
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
