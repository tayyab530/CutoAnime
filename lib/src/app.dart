import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: 'CutoAnime',
        home: Home(),
      ),
    );
  }
}