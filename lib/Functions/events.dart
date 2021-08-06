import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:my_app/UI/models/event.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getEvents(String committeeId) async {}

Future getAllEvents(int pageNum) async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/events/?page=$pageNum'));

  var decodedData = jsonDecode(response.body);
  List<Event> events = [];
  decodedData['events'].forEach((e) => events.add(Event.fromJson(e)));
  print(events.length);
  return events;
}

Future findEventComments(int commentCount, String eventId) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/comments/' + eventId));
}
