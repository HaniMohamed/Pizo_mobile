import 'package:flutter/material.dart';

class GradientHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: <Widget>[
      Image.asset('./asset/images/header.jpg',
      height: 250,fit: BoxFit.fill,),
      Card(),
      Positioned.fill(
          child: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.0, 1.1],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0x00000000),
              Color(0x33000000),
            ],
          ),
        ),
      ))
    ]);
  }
}
