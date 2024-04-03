import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCallingModel {
  final String? uid;
  final String? userId;
  final String? callId;
  final Timestamp? meetingTime;

  VideoCallingModel({this.uid, this.userId, this.callId, this.meetingTime});

  VideoCallingModel.fromDocumentSnashot(
      DocumentSnapshot<Map<String, dynamic>?> doc)
      : uid = doc.id,
        userId = doc.data()?["userId"],
        callId = doc.data()?["callId"],
        meetingTime = doc.data()?["meetingTime"];

  VideoCallingModel copyWith(
      {String? uid, String? userId, String? callId, Timestamp? meetingTime}) {
    return VideoCallingModel(
        uid: uid ?? this.uid,
        userId: userId ?? this.userId,
        callId: callId ?? this.callId,
        meetingTime: meetingTime ?? this.meetingTime);
  }
}
