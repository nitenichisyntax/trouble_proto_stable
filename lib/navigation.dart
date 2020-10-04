import 'package:flutter/material.dart';

import 'home.dart';
import 'map.dart';
import 'perfil.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    FullScreenMap(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[500],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed),
              title: Text("Mapa"),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_emoticon),
              title: Text("Perfil"),
              backgroundColor: Colors.green),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
