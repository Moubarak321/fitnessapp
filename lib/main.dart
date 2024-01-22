// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fitnessapp/common/color_extension.dart';
// // import 'package:fitnessapp/screens/on_boarding/on_boarding_view.dart';
// import 'package:fitnessapp/screens/on_boarding/started_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

//   //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   //mode portrait
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(const MyApp());
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Gérez les notifications lorsque l'application est en arrière-plan
//   'Title: ${message.notification?.title}';
//   'Body: ${message.notification?.body}';
//   'Payload: ${message.data}';
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fitness',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // TRY THIS: Try running your application with "flutter run". You'll see
//           // the application has a purple toolbar. Then, without quitting the app,
//           // try changing the seedColor in the colorScheme below to Colors.green
//           // and then invoke "hot reload" (save your changes or press the "hot
//           // reload" button in a Flutter-supported IDE, or press "r" if you used
//           // the command line to start the app).
//           //
//           // Notice that the counter didn't reset back to zero; the application
//           // state is not lost during the reload. To reset the state, use hot
//           // restart instead.
//           //
//           // This works for code too, not just values: Most code changes can be
//           // tested with just a hot reload.
//           primaryColor: Tcolor.primaryColor1,
//           fontFamily: "Poppins"),
//       // home: const OnboardingView(),
//       home: const StartedView(),
//     );
//   }
// }

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fitnessapp/common/color_extension.dart';
// import 'package:fitnessapp/screens/on_boarding/started_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   runApp(const MyApp());
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Gérez les notifications lorsque l'application est en arrière-plan
//   'Title: ${message.notification?.title}';
//   'Body: ${message.notification?.body}';
//   'Payload: ${message.data}';
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//     final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   late bool _initialized;
//   late bool _error;
//     late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     initInfo();

//     /// whenever your initialization is completed, remove the splash screen:
//     // Future.delayed(Duration(seconds: 5)).then((value) => {
//     // Future.delayed(Duration(seconds: 5), () {
//     //   FlutterNativeSplash.remove();
//     //   navigatorKey.currentState
//     //       ?.pushReplacementNamed(initializeAppAndNavigate() as String);
//     // });
//   }

//   //========================== nouveau initinfo chatgpt ===========================
//   void initInfo() async {
//     try {
//       // Initialisation des notifications locales
//       var androidInitialize =
//           AndroidInitializationSettings('@mipmap-mdpi/launcher_icon');
//       var initializationSettings =
//           InitializationSettings(android: androidInitialize);
//       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//       await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (payload) async {
//           try {
//             // Gérer la réponse à la notification locale si nécessaire
//           } catch (e) {
//             print('Erreur lors de la gestion de la notification : $e');
//           }
//         },
//       );

//       // Écouter les notifications Firebase Cloud Messaging
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         print(
//             'onMessage: ${message.notification?.title}/${message.notification?.body}');

//         // Paramètres pour la notification locale
//         var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//           'bdfood', // Assurez-vous que le nom du canal correspond
//           'bdfood',
//           importance: Importance.high,
//           priority: Priority.high,
//           playSound: true,
//           enableVibration: true,
//           //sound: RawResourceAndroidNotificationSound(_sound),
//         );

//         var platformChannelSpecifics =
//             NotificationDetails(android: androidPlatformChannelSpecifics);

//         // Afficher la notification locale
//         await flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification?.title ?? '',
//           message.notification?.body ?? '',
//           platformChannelSpecifics,
//           payload: message.data['body'] ??
//               '', // Assurez-vous d'utiliser le bon champ pour le payload
//         );
//       });
//     } catch (e) {
//       print("Erreur lors de l'/initialisation des notifications : $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

// //========================== fin initinfo chatgpt ===========================

//   // Future<void> _initializeFlutterFire() async {
//   //   try {
//   //     await Firebase.initializeApp();
//   //     setState(() {
//   //       _initialized = true;
//   //     });
//   //   } catch (e) {
//   //     setState(() {
//   //       _error = true;
//   //     });
//   //   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_error) {
//       return MaterialApp(
//         title: 'Fitness',
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           body: Center(
//             child: Text('Error initializing Firebase'),
//           ),
//         ),
//       );
//     }

//     if (!_initialized) {
//       return MaterialApp(
//         title: 'Fitness',
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       );
//     }

//     return MaterialApp(
//       title: 'Fitness',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Tcolor.primaryColor1,
//         fontFamily: "Poppins",
//       ),
//       home: const StartedView(),
//     );
//   }
// }

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
