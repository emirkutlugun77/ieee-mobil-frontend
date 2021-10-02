import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createPlantFoodNotification(
    String title, String body, String image) async {
  var notification = await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 3232,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      bigPicture: image,
      notificationLayout: NotificationLayout.Default,
    ),
  );
  print(notification.toString());
}
