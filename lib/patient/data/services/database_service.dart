import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/patient/data/models/blog_model.dart';
import 'package:aarogyam/patient/data/models/videocalling_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  addMeeting(VideoCallingModel videoCallingModel) async {
    await _db.collection("Meetings").doc(uid).collection("Meeting").doc().set({
      "userId": videoCallingModel.userId,
      "callId": videoCallingModel.callId,
      "meetingTime": videoCallingModel.meetingTime
    });
  }

  Future<List<VideoCallingModel>> getAllMeeting() async {
    final snapshot =
        await _db.collection("Meeting").doc(uid).collection("Meeting").get();
    return snapshot.docs
        .map((e) => VideoCallingModel.fromDocumentSnashot(e))
        .toList();
  }

  Future<VideoCallingModel> getMeeting(
      VideoCallingModel videoCallingModel) async {
    final snapshot = await _db
        .collection("Meetings")
        .doc(uid)
        .collection("Meeting")
        .doc(videoCallingModel.uid)
        .get();
    return VideoCallingModel.fromDocumentSnashot(snapshot);
  }

  Future<List<DoctorModel>> getAllDoctor() async {
    final snapshot = await _db.collection("request").get();
    return snapshot.docs
        .map((e) => DoctorModel.fromDocumentSnashot(e))
        .toList();
  }

  Future<DoctorModel> getDoctorByUid(DoctorModel doctorModel) async {
    final snapshot = await _db.collection("request").doc(doctorModel.uid).get();
    return DoctorModel.fromDocumentSnashot(snapshot);
  }

  addToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    _db.collection("Tokens").doc(uid).set({"token": fcmToken});
  }

  Future<DoctorModel> getToken(DoctorModel doctorModel) async {
    final snapshot = await _db.collection("Tokens").doc(doctorModel.uid).get();
    return DoctorModel.fromDocumentSnashot(snapshot);
  }
  Stream<List<BlogModel>> getBlogsStream() {
    return _db.collection("Blogs").snapshots().map(
          (snapshot) => snapshot.docs.map(
            (doc) => BlogModel.fromDocumentSnapshot(doc),
      ).toList(),
    );
  }
}

