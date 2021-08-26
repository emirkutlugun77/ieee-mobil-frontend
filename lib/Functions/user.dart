import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/MinimizedModels/MinCertificate.dart';
import 'package:my_app/MinimizedModels/MinCommittee.dart';
import 'package:my_app/MinimizedModels/MinEvent.dart';

import 'package:my_app/UI/models/post.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getUserSubscriptions(
    String userId, String token, List<MinCommittee> userCommites) async {
  try {
    var response = await http.get(
        Uri.parse(baseUri + 'v1/users/$userId/subscriptions'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var decodedData = await jsonDecode(response.body);
    print(decodedData);
    if (decodedData['subscriptions'] != null) {
      await decodedData['subscriptions']
          .forEach((e) => userCommites.add(MinCommittee(
                id: e['committeeId']['_id'],
                photo: e['committeeId']['photo'],
                subCount: e['committeeId']['subscriptionCount'],
                name: e['committeeId']['name'],
                instaUrl: e['committeeId']['instaUrl'] != null
                    ? e['committeeId']['instaUrl']
                    : 'Instagram Linki Yok',
              )));
      return userCommites;
    } else {
      return [];
    }
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
    if (decodedData['certificates'] != null) {
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
    } else {
      return [];
    }
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
    if (decodedData['eventSessions'] != null) {
      await decodedData['eventSessions'].forEach((e) => events.add(MinEvent(
          photo: e['eventId']['photo'],
          committeeColor: e['eventId']['committeeId']['color'],
          committeeName: e['eventId']['committeeId']['name'],
          id: e['eventId']['_id'],
          name: e['eventId']['name'])));
      return events;
    } else {
      return [];
    }
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
    if (decodedData['posts'] != null) {
      await decodedData['posts'].forEach((e) => posts.add(Post.fromJson(e)));
      return posts;
    } else {
      return [];
    }
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

Future updateUserPhoto(String id, File? image, String token) async {
  var formData = FormData.fromMap({
    'photo': image != null ? await MultipartFile.fromFile(image.path) : null
  });
  var response = await Dio().put(
      'https://ancient-falls-28306.herokuapp.com/v1/users/$id/photo/',
      data: formData,
      options:
          Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));

  return response;
}

Future flagUser(String flaggedBy, String id, String token) async {
  var response = await http.post(
      Uri.parse('https://ancient-falls-28306.herokuapp.com/v1/users/$id/flag'),
      body: {
        'userId': id,
        'flaggedBy': flaggedBy,
      },
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future blockUser(String userId, String blockedUserId, String token) async {
  try {
    var response = await http.post(
        Uri.parse(
            'https://ancient-falls-28306.herokuapp.com/v1/users/$blockedUserId/block'),
        body: {'userId': userId, 'blockedUserId': blockedUserId},
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    return response.statusCode;
  } catch (e) {
    return e;
  }
}

Future unBlockUser(String userId, String blockedUserId, String token) async {
  try {
    var response = await http.post(
        Uri.parse('http://localhost:8080/v1/users/$blockedUserId/unblock'),
        body: {'userId': userId, 'blockedUserId': blockedUserId},
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    return response.statusCode;
  } catch (e) {
    return e;
  }
}
