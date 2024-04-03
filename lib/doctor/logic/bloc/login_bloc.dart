import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginFieldChangedEvent>((event, emit) {
      if (kDebugMode) {
        print('this is login feild changes event');
      }
      if (event.email!.isEmpty ||
          event.email?.trim() == null ||
          !event.email!.contains('@')) {
        emit(LoginEmailInvalidState(error: 'Enter valid email'));
      } else if (event.password!.isEmpty || event.password!.length < 8) {
        emit(LoginPasswordInvalidState(
            error: 'Password must be 8 character long'));
      } else {
        emit(LoginValidState());
        if (kDebugMode) {
          print('login is valid nice');
        }
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

    on<LoginSubmitEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        print('login loading state');
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: event.email!, password: event.password!);
        final uid = userCredential.user!.uid;
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('request')
            .doc(uid)
            .get();
        Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
        final status = data['status'];
        if (status == 'pending') {
          emit(LoginPendingState());
          FirebaseAuth.instance.signOut();
        } else if (status == 'rejected') {
          emit(LoginRejectState());
          FirebaseAuth.instance.signOut();
        } else if(status == 'accepted'){
          emit(LoginAcceptState());
        }
      } on FirebaseAuthException catch (error) {
        emit(ErrorState(error: error.message!));
      }
    });
  }
}




