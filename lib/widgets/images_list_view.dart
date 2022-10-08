import 'package:flutter/material.dart';
import 'package:maraca_map/screens/image.dart';

class ImagesListView extends StatelessWidget {
  const ImagesListView({super.key, required this.images});

  final List<Image> images;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (Image image in images)
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ImageScreen(image: image);
              }),
            ),
            child: image,
          ),
      ],
    );
  }
}
