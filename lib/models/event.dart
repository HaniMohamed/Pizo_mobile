import 'package:intl/intl.dart';

class Event {
  String eventImage;
  String eventName;
  String eventDate;
  String eventDescribtion;
  String eventProvider;

  Event(String eventImage, String eventName, String eventDate,
      String eventDescribtion, String eventProvider) {
    this.eventImage = eventImage;
    this.eventName = eventName;
    this.eventDate = eventDate;
    this.eventDescribtion = eventDescribtion;
    this.eventProvider = eventProvider;
  }

  String getImage() {
    return eventImage;
  }

  String getName() {
    return eventName;
  }

  String getDate() {
    return eventDate;
  }

  String getDescribe() {
    return eventDescribtion;
  }

  String getProvider() {
    return eventProvider;
  }

  String getDay() {
    DateTime date = DateTime.parse(getDate());
    return date.day.toString();
  }

  String getMonth() {
    DateTime date = DateTime.parse(getDate());
    var formatter = new DateFormat('MMM');
    String month = formatter.format(date);
    return month;
  }
}
