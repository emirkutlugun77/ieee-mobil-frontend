import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/blogposts.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';
Future readQr(String eventId, String sessionId, String userId) async {
  var response = await http.post(Uri.parse(baseUri + 'v1/event-sessions/'),
      body: {'eventId': eventId, 'sessionId': sessionId, 'userId': userId});
  var decodedData = json.decode(response.body);
  String message = decodedData['message'];
  print(message);
  return message;
}
