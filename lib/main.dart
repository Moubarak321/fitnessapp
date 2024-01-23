

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/common/color_extension.dart';
import 'package:fitnessapp/screens/on_boarding/on_boarding_view.dart';
import 'package:fitnessapp/screens/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Gérez les notifications lorsque l'application est en arrière-plan
  'Title: ${message.notification?.title}';
  'Body: ${message.notification?.body}';
  'Payload: ${message.data}';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initInfo();

    /// whenever your initialization is completed, remove the splash screen:
    // Future.delayed(Duration(seconds: 5)).then((value) => {
    // Future.delayed(Duration(seconds: 5), () {
    //   FlutterNativeSplash.remove();
    //   navigatorKey.currentState
    //       ?.pushReplacementNamed(initializeAppAndNavigate() as String);
    // });
  }

//========================== nouveau initinfo chatgpt ===========================
  void initInfo() async {
    try {
      // Initialisation des notifications locales
      var androidInitialize =
          AndroidInitializationSettings('@mipmap-mdpi/launcher_icon');
      var initializationSettings =
          InitializationSettings(android: androidInitialize);
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          try {
            // Gérer la réponse à la notification locale si nécessaire
          } catch (e) {
            print('Erreur lors de la gestion de la notification : $e');
          }
        },
      );

      // Écouter les notifications Firebase Cloud Messaging
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print(
            'onMessage: ${message.notification?.title}/${message.notification?.body}');

        // Paramètres pour la notification locale
        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'fitness-d52dd', // Assurez-vous que le nom du canal correspond
          'fitness-d52dd',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          //sound: RawResourceAndroidNotificationSound(_sound),
        );

        var platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        // Afficher la notification locale
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          platformChannelSpecifics,
          payload: message.data['body'] ??
              '', // Assurez-vous d'utiliser le bon champ pour le payload
        );
      });
    } catch (e) {
      print("Erreur lors de l'/initialisation des notifications : $e");
    }
  }

//========================== fin initinfo chatgpt ===========================

  // Future<void> initializeAppAndNavigate() async {
  //   try {
  //     // Vérifiez si l'utilisateur est déjà connecté.
  //     User? user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       DateTime lastLoginTime = user.metadata.lastSignInTime!;
  //       DateTime now = DateTime.now();
  //       DateTime oneMonthAgo = now.subtract(Duration(days: 30));

  //       bool registeredByEmail = user.providerData
  //           .any((userInfo) => userInfo.providerId == 'password');
  //       // bool registeredByPhone = user.providerData.any((userInfo) => userInfo.providerId == 'phoneNumber');

  //       if ((registeredByEmail) && (lastLoginTime.isBefore(oneMonthAgo))) {
  //         await Future.delayed(const Duration(seconds: 5));
  //         navigatorKey.currentState?.pushReplacementNamed('/signInScreen');
  //       } else {
  //         navigatorKey.currentState?.pushReplacementNamed('/home');
  //       }

  //       return;
  //     }

  //     // Si l'utilisateur n'est pas connecté, vous pouvez le rediriger vers l'écran de connexion.
  //     await Future.delayed(const Duration(seconds: 3));
  //     navigatorKey.currentState?.pushReplacementNamed(
  //         '/signInScreen'); // Exemple : Page de connexion
  //   } catch (e) {
  //     print("Erreur lors de l'initialisation de Firebase : $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Tcolor.primaryColor1,
        fontFamily: "Poppins",
      ),
      home: const StartedView(),
    );
  }
}
