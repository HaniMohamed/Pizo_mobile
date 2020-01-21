import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pizo/models/event.dart';
import 'package:pizo/resources/apis/events_api_provider.dart';
import 'package:pizo/resources/sharedprefs.dart';
import 'package:pizo/ui/widgets/lists/events_list.dart';
import 'package:pizo/ui/widgets/lists_item/events_slider_item.dart';

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

  Future<bool> getData() {
    SharedPrefs().getSharedToken().then((token) {
      EventsAPI().getEvents(token).then((evns) {
        setState(() {
          events = evns;
          print(events.length.toString());
        });
      });
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    // getData();

    events.add(Event(
        id: 1,
        title: "Test Event",
        descripe: cons.dummyLorem,
        image:
            "https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        date: "2019-10-10",
        payed: 0,
        owner_name: "proga company",
        owner_id: 5));

    events.add(Event(
        id: 2,
        title: "Medical Event",
        descripe: cons.dummyLorem,
        image: "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        date: "2020-05-12",
        payed: 0,
        owner_name: "company name",
        owner_id: 5));

    events.add(Event(
        id: 3,
        title: "New Test Event",
        descripe: cons.dummyLorem,
        image:
            "https://www.clikapad.com/wp-content/uploads/cropped-Clikapad-systems-for-conferences-and-events-1-1.jpg",
        date: "2020-01-10",
        payed: 0,
        owner_name: "company",
        owner_id: 5));

    events.add(Event(
        id: 4,
        title: "job fair",
        descripe: cons.dummyLorem,
        image:
            "https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
        date: "2020-03-08",
        payed: 0,
        owner_name: "proga company",
        owner_id: 5));

    events.add(Event(
        id: 5,
        title: "First Event",
        descripe: cons.dummyLorem,
        image: "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        date: "2019-12-10",
        payed: 0,
        owner_name: "proga company",
        owner_id: 5));

    events.add(Event(
        id: 6,
        title: "Test dummy event",
        descripe: cons.dummyLorem,
        image: "http://www.goldwater.it/wp-content/uploads/2015/04/Events2.jpg",
        date: "2019-12-10",
        payed: 0,
        owner_name: "proga company",
        owner_id: 5));

    promoEvents.add(EventsSliderItem(events.elementAt(0)));
    promoEvents.add(EventsSliderItem(events.elementAt(1)));
    promoEvents.add(EventsSliderItem(events.elementAt(2)));
    promoEvents.add(EventsSliderItem(events.elementAt(3)));
    promoEvents.add(EventsSliderItem(events.elementAt(4)));
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
          child: events != null && events.length > 0
              ? EventsList(events, events.length)
              : Container(),
        ),
      ],
    );
  }
}
