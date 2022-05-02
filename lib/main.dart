import 'package:explorify/pages/login_page.dart';
import 'package:explorify/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:explorify/pages/home_page.dart';
import 'dart:async';
import 'package:explorify/pages/splash_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notif_handler = NotificationService();
  notif_handler.init();
  notif_handler.periodicNotification();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: SplashScreen(),
      ),
    );
  }
}

class CacheControl extends WidgetsBindingObserver {
  CacheControl() {
    WidgetsBinding.instance?.addObserver(this);
  }
  void _cleanAllCache() {
    //somehow cleans the cache i guess lol
    // i don't know what to do here as I couldn't find any information about it online
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused){
      Future.delayed(
        const Duration(minutes: 15),
        _cleanAllCache,
      );
    }
  }

}