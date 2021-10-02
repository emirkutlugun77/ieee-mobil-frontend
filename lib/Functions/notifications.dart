import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/notification.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getNotifications(
    String userId, String token, List<NotificationModel> notifications) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/notifications/'));

  var decodedData = jsonDecode(response.body);

  await decodedData['notifications'].forEach((notification) {
    List<dynamic> seenBy = notification['seenBy'];

    if (!seenBy.contains(userId)) {
      notifications.add(NotificationModel.fromJson(notification));
    }
  });

  return notifications;
}

Future readNotifications(String userId, String notificationId) async {
  try {
    await http.put(Uri.parse(baseUri + 'v1/notifications/$userId'),
        body: {'userId': userId, 'id': notificationId});
    return 'ok';
  } catch (e) {
    return e.toString();
  }
}
