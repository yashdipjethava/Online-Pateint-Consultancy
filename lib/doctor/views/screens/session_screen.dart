import 'dart:convert';

import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/doctor/logic/bloc/session_bloc/session_bloc.dart';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:aarogyam/patient/views/screens/video_call_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionBloc()..add(OnGetSessionData()),
      child: const _SessionScreen(),
    );
  }
}

class _SessionScreen extends StatelessWidget {
  const _SessionScreen();

  Future<void> _setupPushNotifications(
      String? title, String? body, String? uid) async {
    final fcm = FirebaseMessaging.instance;
    final dbService = DatabaseService();
    final doctorModel = DoctorModel();
    final doctor = await dbService.getToken(doctorModel.copyWith(uid: uid));
    //final uid = FirebaseAuth.instance.currentUser?.uid;
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    var data = {
      'to': doctor.token,
      'priority': 'high',
      'notification': {
        'title': '$title',
        'body': '$body',
      },
      'data': {'type': 'msj', 'id': 'video_call'}
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAa4xmU-w:APA91bESBN8XWk18yUjSSxtgPfmJ3ZN-D8cASk1IvgTpIKAyOSuJTsRx2s9xo_1tap0eKesHsumZNUQudEuyrAdd90u8sYznUUIou2RQtClsmKpmGfW0nV5yw8qCiATss7ACNcrOSXYU'
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.error.isNotEmpty) {
            return Center(
              child: Text(state.error),
            );
          } else if (state.sessionData.isEmpty) {
            return const Center(
              child: Text("You have't session."),
            );
          }

          return ListView.builder(
              itemCount: state.sessionData.length,
              itemBuilder: (context, index) {
                final data = state.sessionData[index];
                return ExpansionTile(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (_) => SessionDetailScreen(
                  //         data: data,
                  //       ),
                  //     ),
                  //   );
                  // },
                  title: Text(data.option ?? ""),
                  subtitle: Text(
                      "${DateFormat("dd MMM yyyy").format(data.meetingTime!.toDate())} Meetings"),
                  trailing: Text("\₹${data.price ?? ""}"),
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          itemCount: data.times!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              subtitle: Text(data.option ?? ""),
                              title: Text(
                                  "Meeting time ${DateFormat("hh:mm").format(data.times![index]["slot${index + 1}"][0].toDate())}"),
                              trailing:
                                  LayoutBuilder(builder: (contex, constais) {
                                if (DateTime.now().isAfter(data.times![index]
                                        ["slot${index + 1}"][0]
                                    .toDate()
                                    .add(const Duration(minutes: 30)))) {
                                  return TextButton(
                                      onPressed: () {},
                                      child: const Text("Meeting is Over"));
                                } else
                                 if (data.times![index]
                                    ["slot${index + 1}"][1]) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      final uid = FirebaseAuth
                                          .instance.currentUser?.uid;
                                      final dbService = DatabaseService();
                                      final doctorModel = DoctorModel();
                                      final doc =
                                          await dbService.getDoctorByUid(
                                              doctorModel.copyWith(uid: uid));
                                      _setupPushNotifications(
                                          "Meeting started.",
                                          "Dr.${doc.name} is waiting for you.",
                                          data.times![index]["slot${index + 1}"]
                                              [2]);
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => VideoCallScreen(
                                                    uid: data.uid!,
                                                    userId: uid!,
                                                    userName:
                                                        doc.name ?? "Doctor",
                                                  )));
                                    },
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.green)),
                                    child: const Text(
                                      "Start Meeting",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                } else {
                                  return TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Not Booked",
                                      ));
                                }
                              }),
                            );
                          }),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
