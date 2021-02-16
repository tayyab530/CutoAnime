import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  

  
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        'https://st2.depositphotos.com/1192512/5197/v/950/depositphotos_51976097-stock-illustration-peeking-out-curious-cat-background.jpg',
        // height: 100.0,
        // width: 100.0,
      ),
    );
  }
}