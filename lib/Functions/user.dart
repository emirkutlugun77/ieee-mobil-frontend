import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/auth/login.dart';
import 'package:my_app/UI/models/certificates.dart';
import 'package:my_app/UI/models/commitee.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/post.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getUserSubscriptions(
    String userId, String token, List<Commitee> userCommites) async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/users/$userId/subscriptions'));
  var decodedData = await jsonDecode(response.body);
}

Future checkCertificates(
    String userId, String token, List<Certificate> certificates) async {
  var response = await http
      .get(Uri.parse(baseUri + 'v1/users/me/certificates/?userId=' + userId));
  var decodedData = await jsonDecode(response.body);
}

Future getUserAttendedEvents(
    String userId, String token, List<Event> events) async {
  var response = await http.get(
      Uri.parse(baseUri + 'v1/event-sessions/users/' + userId),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  var decodedData = await jsonDecode(response.body);
}

Future getAllPostsByUserId(
    String userId, String token, List<Post> posts) async {
  var response =
      await http.get(Uri.parse(baseUri + 'v1/post?userId=' + userId));
  var decodedData = await jsonDecode(response.body);
}

Future<bool> getUserData(
    String userId,
    List<Commitee> userCommites,
    List<Certificate> certificates,
    List<Event> events,
    List<Post> posts) async {
  var prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  await Future.wait([
    getUserSubscriptions(userId, token!, userCommites),
    checkCertificates(userId, token, certificates),
    getUserAttendedEvents(userId, token, events),
    getAllPostsByUserId(userId, token, posts)
  ]);
  return true;
}
