import 'package:flutter/material.dart';

class HomeIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
          padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                color: Colors.blue,
                size: 25,
              ),
              Text(
                "Sell item",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.build,
                color: Colors.blue,
                size: 25,
              ),
              Text(
                "Maintenance",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.business_center,
                color: Colors.blue,
                size: 25,
              ),
              Text(
                "Jobs",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: Colors.blue,
                size: 25,
              ),
              Text(
                "Events",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
