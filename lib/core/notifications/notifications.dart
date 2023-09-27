


import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SendAppNotifications {


  static Future<void> sendNotificationToTopic(String topic, String title, String body) async {
    const serverKey = 'AAAAFmu6Mu0:APA91bEvqWiA-u9v34LqUtTn4Gay6sRBCM6TIZlxF7Ez_2cj0UnhyU-tMd2cfsMMuDYmUx6skyv3IWWhpSs2_xS7Z7m_ugn0BqO5es3KUFisGUTWTPMazfE5Sbphe1OuzdqWQp5UGwTy';
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final message = {
      'notification': {
        'title': title,
        'body': body,
      },
      'to': '/topics/$topic',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Notification sent successfully.');
        }
      } else {
        if (kDebugMode) {
          print('Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

}