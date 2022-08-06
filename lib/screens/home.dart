import 'package:flutter/material.dart';
import 'package:flutter_local_notification/screens/second_screen.dart';
import 'package:flutter_local_notification/services/local_notification_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocalNotificationService service;

  @override
  void initState() {
    super.initState();

    service = LocalNotificationService();
    service.myInitialize();

    listenToNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification Demo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'This is a demo of how to use local notifications in Flutter.',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotification(
                        id: 0,
                        title: 'Notification Title',
                        body: 'Some body of the notification!',
                      );
                    },
                    child: const Text('Show Local Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                        id: 0,
                        title: 'Notification Title',
                        body: 'Some body of the showScheduledNotification!',
                        seconds: 2,
                      );
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                        id: 0,
                        title: 'Notification Title',
                        body: 'Some body of the notification!',
                        payload: 'Payload navigation',
                      );
                    },
                    child: const Text('Show Notification With Payload'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotification() {
    service.onNotificationClick.stream.listen(onNotificationListener);
  }

  // Execute when we open the notification with payload
  void onNotificationListener(String? payload) {
    print('Notification opened!');
    if (payload != null && payload.isNotEmpty) {
      print('onNotificationListener Payload: $payload');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(payload: payload),
        ),
      );
    }
  }
}
