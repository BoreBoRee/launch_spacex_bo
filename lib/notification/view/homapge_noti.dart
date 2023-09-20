import 'package:flutter/material.dart';
import 'package:launch_spacex/notification/firebase_message.dart';
import 'package:launch_spacex/notification/services/locator.dart';

class HomepageNoti extends StatefulWidget {
  const HomepageNoti({Key? key}) : super(key: key);

  @override
  State<HomepageNoti> createState() => _HomepageNotiState();
}

class _HomepageNotiState extends State<HomepageNoti> {
  final PushNotificationService pushNotificationService =
      locator<PushNotificationService>();
//..
  @override
  void initState() {
    pushNotificationService.initialise();
    pushNotificationService.setupInteractedMessage(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: pushNotificationService.getTitle,
            builder: (context, title, _) {
              return Text(
                "${title ?? ""}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
//....
          ValueListenableBuilder<String?>(
            valueListenable: pushNotificationService.getBody,
            builder: (context, body, _) {
              return Text(
                "${body ?? ""} ",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              );
            },
          )
        ],
      ),
    );
  }
}
