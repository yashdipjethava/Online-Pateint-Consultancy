//bloc state
part of 'signup_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpValidState extends SignUpState {}

class SignUpNameInvalidState extends SignUpState {
  SignUpNameInvalidState({required this.error});
  String error;
}
class SignUpDobInvalidState extends SignUpState {
  SignUpDobInvalidState({required this.error});
  String error;
}
class SignUpAddreesInvalidState extends SignUpState {
  SignUpAddreesInvalidState({required this.error});
  String error;
}
class SignUpSpaicalistInvalidState extends SignUpState {
  SignUpSpaicalistInvalidState({required this.error});
  String error;
}
class SignUpExperinceInvalidState extends SignUpState {
  SignUpExperinceInvalidState( { required this.error } );
  String error;
}
class SignUpGeneralfeeInvalidState extends SignUpState {
  SignUpGeneralfeeInvalidState({required this.error});
  String error;
}

class SignUpEmailInvalidState extends SignUpState {
  SignUpEmailInvalidState({required this.error});
  String error;
}

class SignUpPasswordInvalidState extends SignUpState {
  SignUpPasswordInvalidState({required this.error});
  String error;
}

class SignUpUserPhotoInvalidState extends SignUpState {
  SignUpUserPhotoInvalidState({required this.error});
  String error;
}
class SignUpUserCertificateInvalidState extends SignUpState {
  SignUpUserCertificateInvalidState({required this.error});
  String error;
}


class SignUpLoadingState extends SignUpState {}

class SignUpSubmitState extends SignUpState {}

class PassVisibilityState extends SignUpState {
  PassVisibilityState({required this.isOn});
  bool isOn;
}

class ErrorState extends SignUpState {
  ErrorState({this.error});
  String?error;
}