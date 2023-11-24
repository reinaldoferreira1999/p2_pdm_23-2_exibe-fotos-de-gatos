import 'package:flutter/material.dart';
import '../models/image_model.dart';

class Images extends StatelessWidget {
  final List<ImageModel> imagens;

  const Images(this.imagens, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      trackVisibility: true,
      child: ListView.builder(
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          return Image.network(
            imagens[index].url,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          );
        },
      ),
    );
  }
}