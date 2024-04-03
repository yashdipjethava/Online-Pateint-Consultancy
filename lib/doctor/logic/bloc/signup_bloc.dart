//bloc
import 'dart:io';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpFieldChangeEvent>((event, emit) {
      try {
        if (event.person == null) {
          emit(SignUpUserPhotoInvalidState(error: 'Please upload your photo'));
        } else if (event.name.isEmpty) {
          emit(SignUpNameInvalidState(error: 'Enter valid name'));
        } else if (event.dob.isEmpty) {
          emit(SignUpDobInvalidState(error: 'Enter your Date of birth'));
        } else if (event.address.isEmpty || event.address.length < 15) {
          emit(SignUpAddreesInvalidState(error: 'Enter your valid address'));
        } else if (event.specialist.isEmpty) {
          emit(SignUpSpaicalistInvalidState(error: 'Enter you Spacailist'));
        } else if (event.experience.isEmpty) {
          emit(SignUpSpaicalistInvalidState(error: 'Enter you Experience'));
        }else if (event.generalFee.isEmpty) {
          emit(SignUpGeneralfeeInvalidState(
              error: 'Enter your GeneralfeeAmount'));
        } else if (event.email.isEmpty || !event.email.contains('@gmail.com')) {
          emit(SignUpEmailInvalidState(error: 'Enter valid email'));
        } else if (event.password.isEmpty || event.password.length < 8) {
          emit(SignUpPasswordInvalidState(
              error: 'Password must be 8 character'));
        } else if (event.certificate == null) {
          emit(SignUpUserCertificateInvalidState(
              error: 'Please upload your Certificate'));
        } else {
          emit(SignUpValidState());
        }
      } catch (ex) {
        debugPrint(ex.toString());
      }
    });

    on<PassVisibilityFalseEvent>(
      (event, emit) {
        emit(PassVisibilityState(isOn: false));
      },
    );

    on<PassVisibilityTrueEvent>(
      (event, emit) {
        emit(PassVisibilityState(isOn: true));
      },
    );

    on<SignUpSubmitEvent>((event, emit) async {
      try {
        emit(SignUpLoadingState());
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.email, password: event.password);

        final person = FirebaseStorage.instance
            .ref()
            .child('docterimage')
            .child('${userCredentials.user!.uid}.jpg');

        await person.putFile(event.person!);
        final personUrl = await person.getDownloadURL();

        final cerificate = FirebaseStorage.instance
            .ref()
            .child('doctercertificate')
            .child('${userCredentials.user!.uid}.jpg');

        await cerificate.putFile(event.certificate!);
        final certificateUrl = await cerificate.getDownloadURL();

        FirebaseFirestore.instance
            .collection('request')
            .doc(userCredentials.user!.uid)
            .set({
          'name': event.name,
          'dob': event.dob,
          'address': event.address,
          'specialist': event.specialist,
          'experience' : event.experience + ' years',
          'generalFee': event.generalFee,
          'email': event.email,
          'password': event.password,
          'image': personUrl,
          'certificate': certificateUrl,
          'status': 'pending',
        });
        final databaseService = DatabaseService();
        databaseService.addToken();
        String userId = userCredentials.user!.uid;
        FirebaseFirestore.instance
            .collection('userRole')
            .doc(userId)
            .set({'role': 'doctor'});
        emit(SignUpSubmitState());
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          emit(ErrorState(error: error.message));
        }
      }
    });
  }
}
