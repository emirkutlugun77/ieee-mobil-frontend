import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/notification.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getNotifications(
    String userId, String token, List<Notification> notifications) async {
  var response =
      await http.get(Uri.parse('http://localhost:8080/v1/notifications/'));

  var decodedData = jsonDecode(response.body);

  await decodedData['notifications'].forEach((notification) {
    if (!notification['seenBy'].contains(userId)) {
      notifications.add(Notification.fromJson(notification));
    }
  });
  print(notifications);
  return notifications;
}
