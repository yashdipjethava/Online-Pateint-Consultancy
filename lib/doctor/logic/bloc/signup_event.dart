//bloc event
part of 'signup_bloc.dart';
abstract class SignUpEvent {}

class SignUpFieldChangeEvent extends SignUpEvent {
  SignUpFieldChangeEvent(
      {
        required this.name,
        required this.dob,
        required this.address,
        required this.specialist,
        required this.generalFee,
        required this.email,
        required this.password,
        required this.person,
        required this.certificate,
        required this.experience,
      });
  String name;
  String dob;
  String address;
  String specialist;
  String generalFee;
  String email;
  String password;
  String experience;
  File? person;
  File? certificate;
}

class SignUpSubmitEvent extends SignUpEvent {
  SignUpSubmitEvent(
      {
        required this.name,
        required this.dob,
        required this.address,
        required this.specialist,
        required this.generalFee,
        required this.email,
        required this.password,
        required this.person,
        required this.certificate,
        required this.experience,
      });
  String name;
  String dob;
  String address;
  String specialist;
  String generalFee;
  String email;
  String experience;
  String password;
  File? person;
  File? certificate;
}

class EmailVerificationEvent extends SignUpEvent {}

class PassVisibilityFalseEvent extends SignUpEvent {}

class PassVisibilityTrueEvent extends SignUpEvent{}