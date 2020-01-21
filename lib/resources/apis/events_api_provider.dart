import 'package:pizo/models/event.dart';
import 'package:pizo/resources/constants.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class EventsAPI {
  Constants cons = new Constants();

  Future<List<Event>> getEvents(token) async {
    try {
      Response response =
          await Dio().get(cons.domain + "api/v1/events?token=" + token);
      final decoded = JSON.jsonDecode(response.toString());
      var list = decoded['events'] as List;
      List<Event> events = list.map((i) => Event.fromJson(i)).toList();
      return events;
    } catch (e) {
      print(e);
    }

    return null;
  }
}
