import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventsSliderItem extends StatelessWidget {
  String eventImage;
  String eventName;
  String eventDate;

  EventsSliderItem(String eventImage, String eventName, String eventDate) {
    this.eventImage = eventImage;
    this.eventName = eventName;
    this.eventDate = eventDate;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: eventImage,
            width: 300,
            height: 200,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // Box decoration takes a gradient
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0.0, 1.1],
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    Color(0x00000000),
                    Color(0x99000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(  
                    mainAxisSize: MainAxisSize.min,                  
                    children: <Widget>[
                      Text(
                        eventName,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        eventDate,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      margin: EdgeInsets.all(10),
    );
  }
}
