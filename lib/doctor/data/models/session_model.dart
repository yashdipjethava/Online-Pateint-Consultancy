import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String? uid;
  final String? option;
  final String? price;
  final List<dynamic>? times;
  final Timestamp? meetingTime;
  final int? slots;

  SessionModel(
      {this.uid,
      this.option,
      this.price,
      this.times,
      this.meetingTime,
      this.slots});

  SessionModel.fromDocumentSnashot(DocumentSnapshot<Map<String, dynamic>?> doc)
      : uid = doc.id,
        option = doc.data()?["option"],
        price = doc.data()?["price"],
        times = doc.data()?["times"],
        meetingTime = doc.data()?["timestamp"],
        slots = doc.data()?["slots"];

  SessionModel copyWith(
      {String? uid,
      String? option,
      String? price,
      List<dynamic>? times,
      Timestamp? meetingTime,
      int? slots}) {
    return SessionModel(
        uid: uid ?? this.uid,
        option: option ?? this.option,
        price: price ?? this.price,
        times: times ?? this.times,
        meetingTime: meetingTime ?? this.meetingTime,
        slots: slots ?? this.slots);
  }
}
