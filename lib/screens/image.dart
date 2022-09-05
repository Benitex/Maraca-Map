import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key, required this.image});

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: InteractiveViewer(
        clipBehavior: Clip.none,
        child: FractionallySizedBox(
          heightFactor: 1, widthFactor: 1,
          child: image,
        ),
      ),
    );
  }
}
