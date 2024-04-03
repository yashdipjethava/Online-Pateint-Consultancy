import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/patient/data/models/videocalling_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorDatabaseService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  Future<List<SessionModel>> getAllMeeting() async {
    final snapshot =
        await _db.collection("TimeSlot").doc(uid).collection("Slot").get();
    return snapshot.docs
        .map((e) => SessionModel.fromDocumentSnashot(e))
        .toList();
  }

  Future<List<SessionModel>> getAllMeetingByDocId(
      DoctorModel doctorModel) async {
    final snapshot = await _db
        .collection("TimeSlot")
        .doc(doctorModel.uid)
        .collection("Slot")
        .get();
    return snapshot.docs
        .map((e) => SessionModel.fromDocumentSnashot(e))
        .toList();
  }

  Future<VideoCallingModel> getMeetingByUid(SessionModel sessionModel) async {
    final snapshot = await _db
        .collection("TimeSlot")
        .doc(uid)
        .collection("Slot")
        .doc(sessionModel.uid)
        .get();
    return VideoCallingModel.fromDocumentSnashot(snapshot);
  }

  Future<void> updateSlotStatus(
      DoctorModel doctorModel, SessionModel sessionModel) async {
    await _db
        .collection("TimeSlot")
        .doc(doctorModel.uid)
        .collection("Slot")
        .doc(sessionModel.uid)
        .update({"times": sessionModel.times});
  }
}
