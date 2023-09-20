import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint("Handling a background message: ${message.messageId}");
// }

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final ValueNotifier<String?> _title = ValueNotifier(null);
  final ValueNotifier<String?> _body = ValueNotifier(null);

  ValueNotifier<String?> get getTitle => _title;
  ValueNotifier<String?> get getBody => _body;

  set setTitle(titleText) {
    _title.value = titleText;
  }

  set setBody(bodyText) {
    _body.value = bodyText;
  }

  Future initialise() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // Continuously Listening to notification using [onMessage] stream
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Updating the local values
        if (message.notification != null) {
          setTitle = message.notification!.title;
          setBody = message.notification!.body;
        }
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage(context) async {
    // Handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message, context);
    });
  }

//..
  void _handleMessage(RemoteMessage message, BuildContext context) {
    // Updating local values with the values received from the Notification
    if (message.notification != null) {
      setTitle = message.notification!.title;
      setBody = message.notification!.body;
    }
//..
    // Navigating to specific screen
    if (message.data['type'] == 'offer') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => OfferPage(offerData: message.data),
      //   ),
      // );
      Modular.to.navigate('/offer-page');
    }
  }
}
