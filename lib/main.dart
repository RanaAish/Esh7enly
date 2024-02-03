// ignore_for_file: depend_on_referenced_packages

import 'package:esh7enly/core/loader/providerloader.dart';
import 'package:esh7enly/core/widgets/font.dart';
import 'package:esh7enly/views/Login/register.dart';
import 'package:esh7enly/views/loadingview.dart';
import 'package:esh7enly/views/paytabs.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controlls/Homviewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Helper/Binding.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background messa-: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
} */
//"d5iMIlDCSWaSDkMgeqk-YG:APA91bHVXcXfGzvziYBreYcMX8VK1riDBtM6nbkiV2jvTVFORPbaV1QcX9eJMJHEH7l-Do0aGMeejLALv1hgfY0N5yK60yaF4ZlGbUQR5W79RP-4gweRJyyxQ91n0_9HWdaPpg3CcsE7"
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.messageId != "") {
    // print("Have received a background message! Will have to grab the message from here somehow if the user didn't interact with the system tray message link");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  PdfGenerator.init();
  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print(message.notification);

    /*  if (message.data != null) {
       // print('Notification Title: ${message.data['title']}');
        //  print('Notification Body: ${message.data!.body}');
      } */
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
//FirebaseApi().initialnotification();

  Get.put(HomeViewModel());
  await translator.init(
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/',
    // NOT YET TESTED
  );
  configLoading();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => providerloader()),
  ], child: (const LocalizedApp(child: MyApp()))));
}

void configLoading() {
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
}

/*( MultiProvider(providers: [
    
    ChangeNotifierProvider(create: (context) => providerloader()),
 
  ]),(LocalizedApp(child: MyApp()))) */
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    return MaterialApp(
        //theme: appTheme,3w
        // deprecated,

        debugShowCheckedModeBanner: false,
        // ignore: prefer_const_literals_to_create_immutables'
        localizationsDelegates: translator.delegates, // Android + iOS Delegates
        // ignore: deprecated_member_use
        locale: translator.locale, // Active locale
        supportedLocales: translator.locals(),
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(393, 804),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialBinding: Binding(),
                    builder: EasyLoading.init(),
                    home:Loading() ); //Loading()
              });
        });
  }
}
/*flutter_native_splash:
  
  color: "#bc3827"

  android_12:
    
  image: assets/splachscreen.jpeg

     */
    /* Obx(() {
           
                      storage.containsKey(key: 'onbreoading').then((value) {
                        setState(() {
                          checkauth = value;
                          // print(value);
                          //print(value.runtimeType);
                        });
                        bank.getbalance().then((value) {
                          setState(() {
                            balance = value;
                          });
                          //  checkIfLogged();

                          if (checkauth == false) {
                            return (onbroadingpage());
                          } else {
                            storage.containsKey(key: 'auth').then((value) {
                              if (value == true) {
                                if (balance == null) {
                                  return (login());
                                } else {
                                  return (Controllhomeview());
                                }
                              } else {
                                return (login());
                              }
                            });
                          }
                          print("balance ${balance}");
                      
                        });
                      });
                      // not important this command
h


                      
                          return Loading();
                    }) */