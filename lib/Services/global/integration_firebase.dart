// ignore_for_file: unused_local_variable, unused_element

import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseApi {
  final firebasemessiging = FirebaseMessaging.instance;
  Future<void> initialnotification() async {
    //await firebasemessiging.requestPermission();
    await firebasemessiging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fcmtoken = await firebasemessiging.getToken();
   
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    initialpushnotification();
  }

  Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage? message) async {
    if (message == null) return;

    //print('titile ');
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (message.messageId != "") {
      // print("Have received a background message! Will have to grab the message from here somehow if the user didn't interact with the system tray message link");
    }
  }

  void handlemessage(RemoteMessage? message) {
    if (message == null) return;
    //Get.to fawatery فواتيري
    //Get.to(AccountSetting());
  }

  Future initialpushnotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handlemessage);
    // FirebaseMessaging.onMessageOpenedApp.listen(handlemessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      handlemessage(message);
    });
  
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print('Got a message whilst in the foreground!');
     // print(message.notification);

     
    });
    /* FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      handlemessage(message);
    }); */
  }
}

/* 

class Defaultconfigfirebas {
  static FirebaseOptions get getoptions {
    return const FirebaseOptions(
      apiKey: 'AIzaSyCGDYZBaofP0GXxU9zOuWd-SZGONrKMWH4',
      appId: '1:521329644225:android:ee2bfe8ea3924bc0c63a40',
      messagingSenderId: '521329644225',
      projectId: 'clinic-34939',
      androidClientId:
          "521329644225-33rion86vkqno5qbffdle0p8mo4nmnap.apps.googleusercontent.com",
    );
  }
}
 FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value;
      
      });
    }); */
