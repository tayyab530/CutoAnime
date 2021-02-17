import 'dart:math';

import '../widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    catController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    catAnimation = Tween(begin: -100.0, end: -200.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );

    boxAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) 
          boxController.reverse();
        else if(status == AnimationStatus.dismissed)
          boxController.forward();
      },
    );

    boxController.forward();
  }

  onTap() {
    var status = catAnimation.status;

    switch (status) {
      case AnimationStatus.dismissed:
        catController.forward();
        break;
      case AnimationStatus.completed:
        catController.reverse();
        break;
      case AnimationStatus.forward:
        catController.reverse();
        break;
      case AnimationStatus.reverse:
        catController.forward();
        break;
      default:
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('CutoAnime'),
        ),
        body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCatAnimation(context),
                buildBox(),
                buildLeftFlap(),
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget buildCatAnimation(BuildContext ctx) {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (ctx, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 8.0,
      top: 2.5,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (ctx, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
        child: Container(
          height: 10.0,
          width: 120.0,
          color: Colors.brown,
        ),
      ),
    );
  }
}
