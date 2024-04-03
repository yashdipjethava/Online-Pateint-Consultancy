// ignore_for_file: file_names, use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:aarogyam/patient/views/screens/video_call_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SessionDetailScreen extends StatelessWidget {
  SessionDetailScreen({super.key, required this.data});
  SessionModel data;

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
      body: ListView.builder(
          itemCount: data.times!.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text(data.option ?? ""),
              title: Text(
                  "Meeting time ${DateFormat("hh:mm").format(data.times![index]["slot${index + 1}"][0].toDate())}"),
              trailing: LayoutBuilder(builder: (contex, constais) {
                if (data.times![index]["slot${index + 1}"][1]) {
                  return ElevatedButton(
                    onPressed: () async {
                      final uid = FirebaseAuth.instance.currentUser?.uid;
                      final dbService = DatabaseService();
                      final doctorModel = DoctorModel();
                      final doc = await dbService
                          .getDoctorByUid(doctorModel.copyWith(uid: uid));
                      _setupPushNotifications("Meeting started.",
                          "Dr.${doc.name} is waiting for you.", data.times![index]["slot${index + 1}"][2]);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VideoCallScreen(
                                    uid: data.uid!,
                                    userId: uid!,
                                    userName: "Katva",
                                  )));
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
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
    );
  }
}
