import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Album> createAlbum(String type) async {
  final response = await http.get(Uri.parse('https://some-random-api.ml/facts/dog')); // url api

  if (response.statusCode == 200) {
    // status code moet 200 zijn om uit te printen.

    print(response.body); // in de console word alle data geprint
    final json = jsonDecode(response.body);
    return Album.fromJson(json);

  } else {
    throw Exception(response.statusCode.toString()); // status code word geprint als het niet gelijk is aan 200
  }
}

class Album {
  final String fact;


  Album({required this.fact});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      fact: json['fact'] ,    // variable fact word gepakt om uit te printen

    );
  }
}
void main() {
  runApp(const MaterialApp(
    title: 'Honden Feitjes', // class om een titel aan te maken in de appbar
    home: SecondRoute(),
  ));
}

class SecondRoute extends StatefulWidget { // class om de knop te linken vanuit de navbar
  const SecondRoute({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<SecondRoute> {
  final TextEditingController _controller = TextEditingController();
  Future <Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honden Feiten',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Honden Feiten'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2.0),
          child: (_futureAlbum== null ) ? buildColumn() : buildFutureBuilder(),

        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network('https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/golden-retriever-royalty-free-image-506756303-1560962726.jpg?crop=0.672xw:1.00xh;0.166xw,0&resize=640:*'),
        ElevatedButton(  // knop met de future album word geprint
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text); // de class wordt geprint waar de variable van de API in staan.
            });
          },
          child: const Text('Klik hier voor een honden feitje! (in het engels)'),

        ),
      ],
    );
  }
// error code of niet
  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) { // als snapshot data heeft, word de fact geprint
          return Text(snapshot.data!.fact );


        } else if (snapshot.hasError) { // error code
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}