import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/event.dart';
import 'package:pizo/widgets/lists/events_list.dart';
import 'package:pizo/widgets/lists_item/events_slider_item.dart';

class EventsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EventsTab();
  }
}

class _EventsTab extends State<EventsTab> {
  List<Widget> promoEvents = new List();

  List<Event> events = new List();

  @override
  void initState() {
    super.initState();

    promoEvents.add(EventsSliderItem(
        "https://www.ballygarryhouse.com/upload/slide_images/bhh005.jpg",
        "Fantastic Event",
        "15/09/2020"));
    promoEvents.add(EventsSliderItem(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "Awesome Event",
        "15/09/2020"));
    promoEvents.add(EventsSliderItem(
        "https://www.clikapad.com/wp-content/uploads/cropped-Clikapad-systems-for-conferences-and-events-1-1.jpg",
        "Fantastic Event",
        "15/09/2020"));
    promoEvents.add(EventsSliderItem(
        "https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        "Good Event",
        "15/09/2020"));
    promoEvents.add(EventsSliderItem(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "Fantastic Event",
        "15/09/2020"));

    events.add(Event(
        "https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        "Fantastic Event",
        "2019-09-10",
        "descripe",
        "proga company"));
    events.add(Event(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "Fantastic Event",
        "2019-09-12",
        "descripe",
        "proga company"));
    events.add(Event(
        "https://www.clikapad.com/wp-content/uploads/cropped-Clikapad-systems-for-conferences-and-events-1-1.jpg",
        "Fantastic Event",
        "2019-09-14",
        "descripe",
        "proga company"));
    events.add(Event(
        "https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        "Fantastic Event",
        "2019-10-10",
        "descripe",
        "proga company"));
    events.add(Event(
        "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        "Fantastic Event",
        "2019-12-20",
        "descripe",
        "proga company"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          child: Row(
            children: <Widget>[
              Expanded(
                child: new Container(
                  margin: EdgeInsets.all(5),
                  height: 1.0,
                  color: Colors.grey.withAlpha(50),
                ),
              ),
              Text(
                "Recommends",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontFamily: 'pacifico'),
              ),
              Expanded(
                child: new Container(
                  margin: EdgeInsets.all(5),
                  height: 1.0,
                  color: Colors.grey.withAlpha(50),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: CarouselSlider(
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              height: 200.0,
              items: promoEvents,
            )),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Upcoming events",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Expanded(
                child: new Container(
                  margin: EdgeInsets.all(5),
                  height: 1.0,
                  color: Colors.grey.withAlpha(50),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        ),
        Container(
          child: events.length > 0
              ? EventsList(events, events.length)
              : Container(),
        ),
      ],
    );
  }
}
