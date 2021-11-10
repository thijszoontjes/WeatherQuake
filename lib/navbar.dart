import 'package:flutter/material.dart';
import 'package:fluttereindopdracht/main.dart';
import 'package:fluttereindopdracht/aardbeving.dart';
import 'package:fluttereindopdracht/dog.dart';



class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('WeerBeving'),
            accountEmail: Text('www.weerbeving.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://image.emojisky.com/512/80512-middle.png',
                  fit: BoxFit.cover, // grootte blauwe vierkant stel je in
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration( // 'css' van de navbar
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      '')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Weer'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp())); // als er op de knop wordt geklikt, link naar class op een andere flutter pagina
            },


          ),
          ListTile(
            leading: Icon(Icons.water_damage), // icoon bij de text
            title: Text('Aardbevingen Nederland'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FirstRoute())); // als er op de knop wordt geklikt, link naar class op een andere flutter pagina
            },


          ),
          ListTile(
            leading: Icon(Icons.directions_walk_outlined),
            title: Text('Honden Feiten'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondRoute())); // als er op de knop wordt geklikt, link naar class op een andere flutter pagina
            },


          ),

          Divider(), // streep bij de text erboven
          ListTile(
            title: Text('Gemaakt door Thijs Zoontjes'),
            leading: Icon(Icons.perm_identity),
 // als er op de knop wordt geklikt, link naar class op een andere flutter pagina


          ),
        ],
      ),
    );
  }
}


