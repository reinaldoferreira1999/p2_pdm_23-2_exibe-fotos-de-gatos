import 'dart:convert';
import 'package:p2/src/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int currentPage = 1;
  List<ImageModel> imagens = [];
  void fetchImages() async {
    var request = http.Request(
        'get',
        Uri.https('api.thecatapi.com', 'v1/images/search',
            {'page': '$currentPage', 'limit': '5'}));
    request.headers.addAll({'x-api-key': ''});
    final result = await request.send();
    if (result.statusCode == 200) {
      final response = await http.Response.fromStream(result);
      var decodedJSON = json.decode(response.body);
      List<ImageModel> fetchedImagens = List.empty(growable: true);
      for (int i = 0; i < 5; i++) {
        var imagem = ImageModel.fromJSON(decodedJSON[i]);
        fetchedImagens.add(imagem);
      }
      setState(() {
        currentPage++;
        imagens.addAll(fetchedImagens);
      });
    } else {
      print('Falhou!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fotos de Gatos'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: fetchImages,
            child: const Icon(Icons.add_a_photo_outlined)),
        body: Images(imagens),
      ),
    );
  }
}