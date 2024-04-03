import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:aarogyam/patient/data/services/notification_servies.dart';
import 'package:aarogyam/splashscreen.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/bottomnavigationbar.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'doctor/views/screens/doctor_HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyA5KSYy-dfvGietMHrUz07bc8ZAgzJu-3g',
        appId: '1:461917017068:android:852a2ce40636e9b2fd26c9',
        messagingSenderId: '461917017068',
        projectId: 'aarogyam-80aa2'),
  );
  // Initialize Firebase App Check
  await FirebaseAppCheck.instance.activate();
  FirebaseMessaging.onBackgroundMessage(backGrounHandler);

  runApp(
    BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}

Future<void> backGrounHandler(RemoteMessage message) async {
  NotificationService.showNotification(
      dateTime: DateTime.now(),
      title: message.notification!.title,
      body: message.notification!.body);
}

void isTokenRefresh() {
  FirebaseMessaging.instance.onTokenRefresh.listen(
    (event) async {
      DatabaseService databaseService = DatabaseService();
      databaseService.addToken();
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (kDebugMode) {
          print("FirebaseMessaging.instance.getInitialMessage");
        }
        if (message != null) {
          if (kDebugMode) {
            print("New Notification");
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        if (kDebugMode) {
          print("FirebaseMessaging.onMessage.listen");
        }
        if (message.notification != null) {
          if (kDebugMode) {
            print(message.notification!.title);
          }
          if (kDebugMode) {
            print(message.notification!.body);
          }
          if (kDebugMode) {
            print("message.data ${message.data}");
          }
          NotificationService.showNotification(
              dateTime: DateTime.now(),
              title: message.notification!.title,
              body: message.notification!.body);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (kDebugMode) {
          print("FirebaseMessaging.onMessageOpenedApp.listen");
        }
        if (message.notification != null) {
          if (kDebugMode) {
            print(message.notification!.title);
          }
          if (kDebugMode) {
            print(message.notification!.body);
          }
          if (kDebugMode) {
            print("message.data22 ${message.data['_id']}");
          }
        }
      },
    );
    NotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) {
        return previous is AuthInitialState;
      },
      builder: (context, state) {
        return FutureBuilder<Widget?>(
          future: _buildMainWidget(context, state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data ?? const Scaffold(); // Handle null case
            } else {
              return const Scaffold(); // Loading or error state
            }
          },
        );
      },
    );
  }
}

Future<Widget?> _buildMainWidget(BuildContext context, AuthState state) async {
  if (state is AuthLoggedInState) {
    User? user = FirebaseAuth.instance.currentUser;
    var userRoleSnapshot = await FirebaseFirestore.instance
        .collection('userRole')
        .doc(user?.uid)
        .get();

    if (userRoleSnapshot.exists) {
      var userRole = userRoleSnapshot.data()?['role'];
      if (userRole == 'patient') {
        return const BottomNavigationScreen();
      } else if (userRole == 'doctor') {
        return const DoctorHomePage();
      }
    } else {
      //please return that user not found
    }
  } else if (state is AuthLoggedOutState) {
    return const PatientLoginScreen();
  } else {
    // Splash Screen for future
    return null;
  }
  return null;
}





