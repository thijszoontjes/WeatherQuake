
import 'package:fluttereindopdracht/data_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttereindopdracht/models.dart';
import 'package:fluttereindopdracht/navbar.dart';
import 'package:fluttereindopdracht/aardbeving.dart';
// alle imports van packages en andere flutter bestanden


void main() {
  runApp(MyApp(
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController(); // variable om een tekst feld te maken, wat je kan aanpassen
  final _dataService = DataService(); // uit de material package

  WeatherResponse? _response; // hier staan alle json varaible in

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          drawer:NavBar(),
          appBar: AppBar(),
          // children:AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // centering
              children: [
                if (_response != null) // als de response niet gelijk aan staat aan null, worden er 3 data dingen geprint.
                  Column(
                    children: [
                      Image.network(_response!.iconUrl),
                      Text(
                        '${_response!.tempInfo.temperature}°',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(_response!.weatherInfo.description)
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50), // tekst en knop staat in het midden
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                        controller: _cityTextController, // kan aangepast worden (is een invoer veld)
                        decoration: InputDecoration(labelText: 'Voer een stad in:'),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Toon temparatuur'))  // nadat er geklikt is, komt de response tevoorschijn uit de search

              ],
            ),
          ),
        ));

  }
// response om weer te krijgen
  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text); // response word gebruikt met de city en de input knop
    setState(() => _response = response); // de gebruikskers interface kan worden aangepast als het object aangepast word
  }
}


