import '../widgets/cat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  initState() {
    super.initState();

    catController =
        AnimationController(duration: Duration(seconds: 1, milliseconds: 200), TickerProvider: this);

    catAnimation = Tween(begin: -140.0, end: -200.0).animate(CurvedAnimation(
      parent: catController,
      curve:  Curves.easeIn,
    ));
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
              alignment: AlignmentDirectional.center,
              children: [
                buildCatAnimation(context),
                buildBox(),
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
}
