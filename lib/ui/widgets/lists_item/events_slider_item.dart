import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/event.dart';
import 'package:pizo/ui/screens/event_details.dart';

class EventsSliderItem extends StatelessWidget {
  Event event;
  String heroTag;

  EventsSliderItem(Event event) {
    this.event = event;
    heroTag = "slider" + event.getID().toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetails(event, heroTag),
            ));
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: heroTag,
              child: CachedNetworkImage(
                imageUrl: event.getImage(),
                width: 300,
                height: 200,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => new Container(
                  width: 300,
                  height: 200,
                  child: Icon(Icons.error),
                ),
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.getTitle(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          event.getDate(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
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
      ),
    );
  }
}
