import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:my_app/UI/models/announcement.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getAnnouncements(String token) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/announcements/'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

  List<Announcement> announcements = [];
  var decodedData = jsonDecode(response.body);
  await decodedData['announcements']
      .forEach((e) => announcements.add(Announcement.fromJson(e)));
  return announcements;
}
