import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';

import 'package:my_app/UI/models/post.dart';

import 'package:shared_preferences/shared_preferences.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getUserSubscriptions(
    String userId, String token, List<MinCommittee> userCommites) async {
  try {
    var response = await http.get(
        Uri.parse(baseUri + 'v1/users/$userId/subscriptions'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var decodedData = await jsonDecode(response.body);
    await decodedData['subscriptions']
        .forEach((e) => userCommites.add(MinCommittee(
              id: e['committeeId']['_id'],
              photo: e['committeeId']['photo'],
              subCount: e['committeeId']['subscriptionCount'],
              name: e['committeeId']['name'],
              instaUrl: e['committeeId']['instaUrl'],
            )));
    return userCommites;
  } catch (e) {
    throw new Exception(e);
  }
}

Future checkCertificates(
    String userId, String token, List<MinCertificate> certificates) async {
  try {
    var response = await http.get(
        Uri.parse(baseUri + 'v1/users/me/certificates/?userId=' + userId),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var decodedData = await jsonDecode(response.body);
    await decodedData['certificates']
        .forEach((e) => certificates.add(MinCertificate(
              fontSize: e['fontSize'],
              id: e['_id'],
              x: e['x'],
              y: e['y'],
              photo: e['photo'],
              fontUrl: e['googleFontUrl'],
            )));
    return certificates;
  } catch (e) {
    throw new Exception(e);
  }
}

Future getUserAttendedEvents(
    String userId, String token, List<MinEvent> events) async {
  try {
    var response = await http.get(
        Uri.parse(baseUri + 'v1/event-sessions/users/' + userId),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var decodedData = await jsonDecode(response.body);
    await decodedData['eventSessions'].forEach((e) => events.add(MinEvent(
        photo: e['eventId']['photo'],
        committeeColor: e['eventId']['committeeId']['color'],
        committeeName: e['eventId']['committeeId']['name'],
        id: e['eventId']['_id'],
        name: e['eventId']['name'])));
    return events;
  } catch (e) {
    throw new Exception(e);
  }
}

Future getAllPostsByUserId(
    String userId, String token, List<Post> posts) async {
  try {
    var response = await http.get(
        Uri.parse(baseUri + 'v1/post?userId=' + userId),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var decodedData = await jsonDecode(response.body);

    await decodedData['posts'].forEach((e) => posts.add(Post.fromJson(e)));
    return posts;
  } catch (e) {
    throw new Exception(e);
  }
}

Future<bool> getUserData(
    String userId,
    List<MinCommittee> userCommites,
    List<MinCertificate> certificates,
    List<MinEvent> events,
    List<Post> posts,
    String token) async {
  await Future.wait([
    getUserSubscriptions(userId, token, userCommites),
    checkCertificates(userId, token, certificates),
    getUserAttendedEvents(userId, token, events),
    getAllPostsByUserId(userId, token, posts)
  ]);
  return true;
}
