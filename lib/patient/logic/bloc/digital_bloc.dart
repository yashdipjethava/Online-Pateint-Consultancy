import 'dart:developer';

import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/doctor/data/services/doctor_database_services.dart';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'digital_event.dart';
part 'digital_state.dart';

class DigitalBloc extends Bloc<DigitalEvent, DigitalState> {
  DigitalBloc()
      : super(DigitalState(
            isLoading: false,
            error: "",
            doctorData: const [],
            sessionData: const [],
            sessionModel: SessionModel())) {
    on<GetDoctorData>(_onGetDoctorData);
    on<GetSlot>(_onGetSlot);
    on<BookSlot>(_onBookSlot);
    on<GetWithoutLoadingSlot>(_onGetWithoutSlot);
  }
  final dbService = DatabaseService();
  final dbDoctorService = DoctorDatabaseService();
  _onGetDoctorData(GetDoctorData event, Emitter<DigitalState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final doctorData = await dbService.getAllDoctor();

      List<DoctorModel> specificData = [];

      for (var doctor in doctorData) {
        log(doctor.specialist.toString());
        log(event.specialist);
        if (doctor.status == "accepted") {
          specificData.add(doctor);
        }
      }
      emit(state.copyWith(doctorData: specificData));
    } catch (ex) {
      emit(state.copyWith(error: ex.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onGetSlot(GetSlot event, Emitter<DigitalState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final doctorModel = DoctorModel();
      final data = await dbDoctorService
          .getAllMeetingByDocId(doctorModel.copyWith(uid: event.uid));
      emit(state.copyWith(sessionData: data));
    } catch (ex) {
      emit(state.copyWith(error: ex.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onGetWithoutSlot(
      GetWithoutLoadingSlot event, Emitter<DigitalState> emit) async {
    try {
      final doctorModel = DoctorModel();
      final data = await dbDoctorService
          .getAllMeetingByDocId(doctorModel.copyWith(uid: event.uid));
      emit(state.copyWith(sessionData: data));
    } catch (ex) {
      emit(state.copyWith(error: ex.toString()));
    }
  }

  _onBookSlot(BookSlot event, Emitter<DigitalState> emit) async {
    try {
      final doctorModel = DoctorModel();
      final sessionModel = SessionModel();
      log(event.list.toString());
      await dbDoctorService.updateSlotStatus(
          doctorModel.copyWith(
            uid: event.docId,
          ),
          sessionModel.copyWith(uid: event.uid, times: event.list));
      add(GetWithoutLoadingSlot(uid: event.docId));
    } catch (ex) {
      emit(state.copyWith(error: ex.toString()));
    }
  }
}
