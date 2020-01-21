import 'package:flutter/material.dart';
import 'package:pizo/models/event.dart';
import 'package:pizo/ui/widgets/lists_item/event_item.dart';

class EventsList extends StatelessWidget {
  List<Event> events;
  int count;

  EventsList(List<Event> events, int count) {
    this.events = events;
    this.count = count;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 10, right: 10),
      children: eventsWidgets(),
    );
  }

  List<Widget> eventsWidgets() {
    List<Widget> widgets = new List();
    for (int i = 0; i < count; i++) {
      widgets.add(EventItem(events.elementAt(i)));
    }
    return widgets;
  }
}
