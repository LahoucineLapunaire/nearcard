import 'package:NearCard/blocs/auth/auth_bloc.dart';
import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/blocs/onboarding/onboarding_bloc.dart';
import 'package:NearCard/blocs/router/router_bloc.dart';
import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:NearCard/screens/app/router.dart';
import 'package:NearCard/screens/onboarding/onboarding.dart';
import 'package:NearCard/screens/setup/setup.dart';
import 'package:NearCard/web/webPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCqIGjuW3NsWcr1QxfQ3Lsw9vOY2WSGA_s",
        appId: "1:443238716364:web:e8a415ee168927fe318369",
        messagingSenderId: "443238716364",
        projectId: "nearcard-fa985",
        storageBucket: "nearcard-fa985.appspot.com",
      ),
    );
    runApp(WebScreen());
  } else {
    await Firebase.initializeApp();
    setSharedPreferences();
    requestPermission();
    getKeysFromRemoteConfig();
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        if (user.emailVerified) {
          initNotification();
          FirebaseMessaging.onBackgroundMessage(
              firebaseMessagingBackgroundHandler);

          print("Verified");
          runApp(const Verified());
        } else {
          print("Not verified");
          runApp(const NotVerified());
        }
      } else {
        print("Unlogged");
        runApp(const UnLogged());
      }
    });
  }
}

Future<void> requestPermission() async {
  final PermissionStatus locationStatus = await Permission.location.request();
  if (locationStatus == PermissionStatus.granted) {
    // Permission granted
  } else if (locationStatus == PermissionStatus.denied) {
    // Permission denied
  } else if (locationStatus == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied
  }
  final PermissionStatus locationAlwaysStatus =
      await Permission.locationAlways.request();
  if (locationAlwaysStatus == PermissionStatus.granted) {
    // Permission granted
  } else if (locationAlwaysStatus == PermissionStatus.denied) {
    // Permission denied
  } else if (locationAlwaysStatus == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied
  }

  final PermissionStatus mediaLocatiosStatus =
      await Permission.accessMediaLocation.request();
  if (mediaLocatiosStatus == PermissionStatus.granted) {
    // Permission granted
  } else if (mediaLocatiosStatus == PermissionStatus.denied) {
    // Permission denied
  } else if (mediaLocatiosStatus == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied
  }

  final PermissionStatus notificationStatus =
      await Permission.notification.request();
  if (notificationStatus == PermissionStatus.granted) {
    // Permission granted
  } else if (notificationStatus == PermissionStatus.denied) {
    // Permission denied
  } else if (notificationStatus == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied
  }
  final PermissionStatus backgroundStatus =
      await Permission.systemAlertWindow.request();
  if (backgroundStatus == PermissionStatus.granted) {
    // Permission granted
  } else if (backgroundStatus == PermissionStatus.denied) {
    // Permission denied
  } else if (backgroundStatus == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied
  }
}

// Function to initialize Firebase Cloud Messaging (FCM) for notifications
void initNotification() async {
  try {
    // Create an instance of FirebaseMessaging
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Subscribe to the "general" topic for receiving notifications
    messaging.subscribeToTopic("general");
    messaging.subscribeToTopic(auth.currentUser!.uid);

    // Request notification permissions from the user
    NotificationSettings settings = await messaging.requestPermission(
      alert: true, // Allow displaying alerts
      announcement: false, // Do not allow announcements
      badge: true, // Show badges on app icon
      carPlay: false, // Disable CarPlay notifications
      criticalAlert: false, // Do not allow critical alerts
      provisional: false, // Notifications are not provisional
      sound: true, // Allow playing notification sounds
    );

    // Print the user's permission status for notifications
    print('User granted permission: ${settings.authorizationStatus}');
    print("Notification initialization completed");

    // Listen for incoming FCM messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("You received a message");
      print("onMessage: ${message.notification?.body}");
      print("onMessage: ${message.data}");
    });
  } catch (e) {
    print("error : ${e.toString()}");
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("You received a Background message");
  print("onMessage: ${message.notification?.body}");
  print("onMessage: ${message.data}");
  return;
}

void setSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('notification') == null) {
    prefs.setBool('notification', true);
  }
}

Future<void> getKeysFromRemoteConfig() async {
  try {
    // Check if a user is currently authenticated.
    if (FirebaseAuth.instance.currentUser != null) {
      // Initialize Firebase Remote Config.
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      // Get the secret keys from Firebase Remote Config.
      final secretKeyId = remoteConfig.getString('private_key_id');
      final secretKey = remoteConfig.getString('private_key');
      //final smtpKey = remoteConfig.getString('smtp_key');

      // Create a SharedPreferences instance to store the keys.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save the keys to SharedPreferences for future use.
      prefs.setString("private_key_id", secretKeyId);
      prefs.setString("private_key", secretKey);
      //prefs.setString("smtp_key", smtpKey);

      // Print a message to confirm that the keys have been saved.
      print("Keys saved to shared preferences");
    }
  } catch (e) {
    // Handle any errors that occur during the process.
    print("Error getting keys: ${e.toString()}");
  }
}

class Verified extends StatelessWidget {
  const Verified({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NearCard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xff001f3f,
            <int, Color>{
              50: Color(0xffe5f1f4),
              100: Color(0xffbfe0e7),
              200: Color(0xff94cdd6),
              300: Color(0xff68bac5),
              400: Color(0xff47aeb9),
              500: Color(0xff27a2ad),
              600: Color(0xff219b9f),
              700: Color(0xff1b8c8f),
              800: Color(0xff177d7f),
              900: Color(0xff0f5f60),
            },
          ),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<RouterBloc>(
              create: (context) => RouterBloc(),
            ),
            BlocProvider<CurrentUserBloc>(
                create: (context) => CurrentUserBloc()),
            BlocProvider<SettingsBloc>(
              create: (context) => SettingsBloc(),
            ),
          ],
          child: const RouterScreen(),
        ));
  }
}

class NotVerified extends StatelessWidget {
  const NotVerified({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xff001f3f,
          <int, Color>{
            50: Color(0xffe5f1f4),
            100: Color(0xffbfe0e7),
            200: Color(0xff94cdd6),
            300: Color(0xff68bac5),
            400: Color(0xff47aeb9),
            500: Color(0xff27a2ad),
            600: Color(0xff219b9f),
            700: Color(0xff1b8c8f),
            800: Color(0xff177d7f),
            900: Color(0xff0f5f60),
          },
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SetupBloc>(
            create: (context) => SetupBloc(),
          ),
        ],
        child: const SetupScreen(),
      ),
    );
  }
}

class UnLogged extends StatelessWidget {
  const UnLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xff001f3f,
          <int, Color>{
            50: Color(0xffe5f1f4),
            100: Color(0xffbfe0e7),
            200: Color(0xff94cdd6),
            300: Color(0xff68bac5),
            400: Color(0xff47aeb9),
            500: Color(0xff27a2ad),
            600: Color(0xff219b9f),
            700: Color(0xff1b8c8f),
            800: Color(0xff177d7f),
            900: Color(0xff0f5f60),
          },
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
        ],
        child: const OnboardingScreen(),
      ),
    );
  }
}
