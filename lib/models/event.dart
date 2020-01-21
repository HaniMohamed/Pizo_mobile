import 'package:intl/intl.dart';
import 'package:pizo/resources/constants.dart';

Constants cons = new Constants();

class Event {
  var id;
  String title;
  String descripe;
  String image;
  String date;
  int payed;
  String owner_name;
  var owner_id;

  Event(
      {this.id,
      this.title,
      this.descripe,
      this.image,
      this.date,
      this.payed,
      this.owner_name,
      this.owner_id});

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(
        id: parsedJson['id'],
        title: cons.domain + parsedJson['title'],
        descripe: parsedJson['descripe'],
        image: parsedJson['image'],
        date: parsedJson['date'],
        payed: parsedJson['payed'],
        owner_name: parsedJson['owner_name'],
        owner_id: parsedJson['owner_id']);
  }

  getImage() {
    return image;
  }

  getID() {
    return id;
  }

  getTitle() {
    return title;
  }

  bool ifPayed() {
    return payed == 1;
  }

  getDescribe() {
    return descripe;
  }

  getOwner() {
    return owner_name;
  }

  getOwnerID() {
    return owner_id;
  }

  getDate() {
    return date;
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
