import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/event.dart';
import 'package:pizo/ui/screens/event_details.dart';

class EventItem extends StatelessWidget {
  Event event;
  String heroTag;

  EventItem(Event event) {
    this.event = event;
    heroTag = event.getID().toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetails(event, heroTag),
            ));
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.all(2),
        child: Card(
          semanticContainer: false,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Hero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      imageUrl: event.getImage(),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => new Container(
                        width: 80,
                        height: 80,
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.lightBlue.withAlpha(150),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            event.getDay(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            event.getMonth(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(event.getTitle(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        event.getOwner(),
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          elevation: 1,
        ),
      ),
    );
  }
}
