import 'package:pregnant_app/models/models.dart';
import 'package:pregnant_app/providers/providers.dart';
import 'package:pregnant_app/services/services.dart';
import 'package:pregnant_app/shared/shared.dart';
import 'package:pregnant_app/ui/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              title: 'Agile Teknik',
              debugShowCheckedModeBanner: false,
              home: Splash(),
            );
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => FilterProvider()),
                ChangeNotifierProvider(create: (context) => VideoProvider()),
                ChangeNotifierProvider(
                    create: (context) => UserProfileProvider()),
                ChangeNotifierProvider(create: (context) => TokenProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Agile Teknik',
                theme: ThemeData(
                  splashColor: Colors.white,
                ),
                home: FutureBuilder(
                  future: Init.instance.getToken(),
                  builder: (BuildContext context,
                      AsyncSnapshot<UserProfileModel?> data) {
                    if (data.connectionState == ConnectionState.waiting) {
                      return Splash();
                    }

                    if (data.data == null) {
                      return LoginPage();
                    } else {
                      return MainPage(user: data.data);
                    }
                  },
                ),
              ),
            );
          } else {
            return MaterialApp(
              title: 'Agile Teknik',
              debugShowCheckedModeBanner: false,
              home: Splash(
                error: true,
              ),
            );
          }
        });
    // }
  }
}

class Splash extends StatelessWidget {
  bool error;
  Splash({this.error = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(20),
                child: Center(child: Image.asset('assets/images/logo.png'))),
            error == true
                ? Text("Koneksi internet terputus",
                    style: whiteTextFont.copyWith(
                        fontSize: 14, fontWeight: FontWeight.bold))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 0));
  }

  Future<UserProfileModel?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    UserProfileModel? user;
    UserServices userServices;

    if (token == null || token == "") {
      return user;
    } else {
      userServices = UserServices(token: token);
      user = await userServices.getUser();
      return user;
    }
  }
}
