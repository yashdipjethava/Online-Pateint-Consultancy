import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? uid;
  final String? token;
  final String? address;
  final String? certificate;
  final String? dob;
  final String? email;
  final String? generalFee;
  final String? image;
  final String? name;
  final String? password;
  final String? specialist;
  final String? status;

  DoctorModel({
    this.uid,
    this.address,
    this.certificate,
    this.dob,
    this.email,
    this.token,
    this.generalFee,
    this.image,
    this.name,
    this.password,
    this.specialist,
    this.status,
  });

  DoctorModel.fromDocumentSnashot(DocumentSnapshot<Map<String, dynamic>?> doc)
      : uid = doc.id,
        address = doc.data()?["address"],
        token = doc.data()?["token"],
        certificate = doc.data()?["certificate"],
        dob = doc.data()?["dob"],
        email = doc.data()?["email"],
        generalFee = doc.data()?["generalFee"],
        image = doc.data()?["image"],
        name = doc.data()?["name"],
        password = doc.data()?["password"],
        specialist = doc.data()?["specialist"],
        status = doc.data()?["status"];

  DoctorModel copyWith({
    String? uid,
    String? address,
    String? certificate,
    String? dob,
    String? email,
    String? token,
    String? generalFee,
    String? image,
    String? name,
    String? password,
    String? specialist,
    String? status,
  }) =>
      DoctorModel(
        uid: uid ?? this.uid,
        address: address ?? this.address,
        certificate: certificate ?? this.certificate,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        generalFee: generalFee ?? this.generalFee,
        image: image ?? this.image,
        name: name ?? this.name,
        token: token ?? this.token,
        password: password ?? this.password,
        specialist: specialist ?? this.specialist,
        status: status ?? this.status,
      );
}
