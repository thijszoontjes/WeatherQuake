import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttereindopdracht/earthquake.model.dart';

createAlbum(String events) async {
  final response = await http.get(Uri.parse( // parse zet het object om in een string
      'https://cdn.knmi.nl/knmi/map/page/seismologie/all_induced.json')); // url api

  if (response.statusCode == 200) {
    // status code moet 200 zijn om uit te printen.

    print(response.body); // in de console word alle data geprint
    final json = jsonDecode(response.body);
    print("JSON $json"); // json file word uitgelezen
    return List<Earthquake>.from(json['events']
        .map((x) => Earthquake.fromJson(x))); // maakt een list van alle data
  } else {
    throw Exception(response.statusCode
        .toString()); // status code word geprint als het niet gelijk is aan 200
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Test', // class om een titel aan te maken in de appbar
    home: FirstRoute(), // hier link de knop heen
  ));
}

class FirstRoute extends StatefulWidget { // class om de knop te linken vanuit de navbar
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<FirstRoute> {
  final TextEditingController _controller = TextEditingController();
  Future? _futureAlbum; // om een variable of error te laten zien

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aardbevingen Nederland',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aardbevingen Nederland'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(9.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(), // word gebouwd op de laatste interactie van de snaphot, buildcolom maakt een nieuwe colom aan wanneer nodig
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
            'https://images0.persgroep.net/rcs/0PfJ9pKhqRc7SDUWxtUzOBvDg4k/diocontent/70069439/_crop/5/9/888/736/_fitwidth/763?appId=93a17a8fd81db0de025c8abd1cca1279&quality=0.8'),
        ElevatedButton(
          // knop met de future album word geprint
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller
                  .text); // de class wordt geprint waar de variable van de API in staan.
            });
          },
          child:
          const Text('Klik hier voor de meest recente aardbevingen'),
        ),
      ],
    );
  }


  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) { // snapshot heeft data
          // return Text(snapshot.data.toString());
          return ListView.builder(
              controller: ScrollController(), // widgets zijn scrollbaar
              shrinkWrap: true, // shrinkwrap is true, dus hij gebruikt de ruimte wat nodig is
              itemBuilder: (BuildContext context, int index) {
                Earthquake earthquake = snapshot.data[index];
                return ListTile(  // deze varaible staan in de listTitle
                  title: Text(earthquake.place.toString()
            ),
                  subtitle: Text(earthquake.time.toString()),
                  trailing: Text(earthquake.mag.toString()), // schaal 1/10 == mag, trailing staat rechts
                );
              },
              itemCount: snapshot.data.length);
        } else if (snapshot.hasError) { // error message als die er is.
          return Text('${snapshot.error}'); // error code
        }

        return const CircularProgressIndicator();  // laad icoontje bij inladen data
      },
    );
  }
}