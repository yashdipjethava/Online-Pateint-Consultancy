import 'dart:convert';
import 'dart:developer';

import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:aarogyam/patient/logic/bloc/digital_bloc.dart';
import 'package:aarogyam/patient/views/screens/video_call_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SessionUserDetailScreen extends StatelessWidget {
  Future<void> _setupPushNotifications(
      String? title, String? body, String? uid) async {
    final fcm = FirebaseMessaging.instance;
    final dbService = DatabaseService();
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
    log(doctor.token.toString());
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

  SessionUserDetailScreen(
      {super.key, required this.data, required this.doctorModel});
  SessionModel data;
  DoctorModel doctorModel;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book slots here"),
      ),
      body: ListView.builder(
          itemCount: data.times!.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text(data.option ?? ""),
              title: Text(
                  "Meeting time ${DateFormat("hh:mm a").format(data.times![index]["slot${index + 1}"][0].toDate())}"),
              trailing: LayoutBuilder(builder: (contex, constais) {
                if (data.times![index]["slot${index + 1}"][1]) {
                  if (data.times![index]["slot${index + 1}"][2] == uid) {
                    return ElevatedButton(
                      onPressed: () {
                        if (DateTime.now().isAfter(data.times![index]
                                    ["slot${index + 1}"][0]
                                .toDate()) &&
                            DateTime.now().isBefore(data.times![index]
                                    ["slot${index + 1}"][0]
                                .toDate()
                                .add(const Duration(minutes: 30)))) {
                          _setupPushNotifications(
                              "Your meeting is start.",
                              "Dr.${doctorModel.name} your patient is waiting.",
                              doctorModel.uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VideoCallScreen(
                                uid: data.uid!,
                                userId: uid!,
                                userName: "Patient",
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (contex) => AlertDialog(
                              content: const Text(
                                  "Meeting time not start or you may missed meeting"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Okay"))
                              ],
                            ),
                          );
                        }
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
                        onPressed: () {}, child: const Text("Booked"));
                  }
                } else {
                  return TextButton(
                      onPressed: () {
                        data.times![index] = {
                          "slot${index + 1}": [
                            data.times![index]["slot${index + 1}"][0],
                            true,
                            uid
                          ]
                        };
                        BlocProvider.of<DigitalBloc>(context).add(BookSlot(
                            docId: doctorModel.uid!,
                            uid: data.uid!,
                            list: data.times!));
                      },
                      child: const Text(
                        "Book Now",
                      ));
                }
              }),
            );
          }),
    );
  }
}
