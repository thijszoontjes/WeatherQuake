import 'dart:convert';
import 'package:fluttereindopdracht/models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(String city) async { // een class om getweather te krijgen
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = { // query gebruik wat ik nodig heb
      'q': city,
      'appid': 'add524720c6b11d0649d761f76e953c8', // api key
      'units': 'metric', // temparatuur is in celcius
      'lang': 'nl' // api taal is in het nederlands
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);   // zo is de url opgebouwd voor de data

    final response = await http.get(uri);

    print(response.body); // in de console ie je de waarde
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}