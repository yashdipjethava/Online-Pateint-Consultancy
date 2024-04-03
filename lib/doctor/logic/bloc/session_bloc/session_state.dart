part of 'session_bloc.dart';

class SessionState extends Equatable {
  const SessionState(
      {required this.isLoading,
      required this.error,
      required this.sessionData,
      required this.sessionModel});
  final bool isLoading;
  final String error;
  final List<SessionModel> sessionData;
  final SessionModel sessionModel;

  SessionState copyWith(
      {bool? isLoading,
      String? error,
      List<SessionModel>? sessionData,
      SessionModel? sessionModel}) {
    return SessionState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        sessionData: sessionData ?? this.sessionData,
        sessionModel: sessionModel ?? this.sessionModel);
  }

  @override
  List<Object> get props => [isLoading, error, sessionData, sessionModel];
}
