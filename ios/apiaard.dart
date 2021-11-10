// import 'dart:async';
// import 'dart:convert';
// import 'package:fluttereindopdracht/aardbeving.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// Future<Album> createAlbum(String type) async {
//   final response = await http.get(Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&orderby=time&minmag=5&limit=100'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     print(response.body);
//     final json = jsonDecode(response.body);
//     return Album.fromJson(json);
//
//
//
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception(response.statusCode.toString());
//   }
// }
//
// class Album {
//   final String type;
//   final  count;
//
//   final types;
//
//   Album({required this.type, required this.count,   required this.types});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       type: json['type'],
//       count: json['count'],
// types: json['types'],
//     );
//   }
// }
//
// void main() {
//   runApp(const MaterialApp(
//     title: 'Test', // class om een titel aan te maken in de appbar
//     home: Third(),
//   ));
// }
//
//
// class Third extends StatefulWidget {
//   const Third({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }
//
// class _MyAppState extends State<Third> {
//   final TextEditingController _controller = TextEditingController();
//   Future<Album>? _futureAlbum;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Test api print',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Test api print'),
//         ),
//         body: Container(
//
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum== null ) ? buildColumn() : buildFutureBuilder(),
//
//         ),
//       ),
//     );
//   }
//
//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         // TextField(
//         //   controller: _controller,
//         //   decoration: const InputDecoration(hintText: 'Enter Title'),
//         // ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureAlbum = createAlbum(_controller.text);
//             });
//           },
//           child: const Text('Laat de data zien'),
//         ),
//       ],
//     );
//   }
// // error code of niet
//   FutureBuilder<Album> buildFutureBuilder() {
//     return FutureBuilder<Album>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.type );
//
//
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }