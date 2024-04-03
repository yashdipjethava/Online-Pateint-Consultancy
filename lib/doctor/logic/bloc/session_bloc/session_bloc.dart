import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/doctor/data/services/doctor_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc()
      : super(SessionState(
            isLoading: false,
            error: "",
            sessionData: const [],
            sessionModel: SessionModel())) {
    on<OnGetSessionData>(_onGetSessionData);
  }
  
  final dbService = DoctorDatabaseService();
  _onGetSessionData(OnGetSessionData event, Emitter<SessionState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final data = await dbService.getAllMeeting();
      emit(state.copyWith(sessionData: data));
    } catch (ex) {
      emit(state.copyWith(error: ex.toString()));
    }finally{
      emit(state.copyWith(isLoading: false));
    }
  }
}
