part of 'digital_bloc.dart';

class DigitalState extends Equatable {
  const DigitalState(
      {required this.isLoading,
      required this.error,
      required this.doctorData,
      required this.sessionData,
      required this.sessionModel});
  final bool isLoading;
  final String error;
  final List<DoctorModel> doctorData;
  final List<SessionModel> sessionData;
  final SessionModel sessionModel;

  DigitalState copyWith(
      {bool? isLoading,
      String? error,
      List<DoctorModel>? doctorData,
      List<SessionModel>? sessionData,
      SessionModel? sessionModel}) {
    return DigitalState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        doctorData: doctorData ?? this.doctorData,
        sessionData: sessionData ?? this.sessionData,
        sessionModel: sessionModel ?? this.sessionModel);
  }

  @override
  List<Object> get props =>
      [isLoading, error, doctorData, sessionData, sessionModel];
}
