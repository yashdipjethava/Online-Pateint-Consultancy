part of 'digital_bloc.dart';

sealed class DigitalEvent extends Equatable {
  const DigitalEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorData extends DigitalEvent {
  final String specialist;

  const GetDoctorData({required this.specialist});
  @override
  List<Object> get props => [specialist];
}

class GetSlot extends DigitalEvent{
  final String uid;

  const GetSlot({required this.uid});
  @override
  List<Object> get props => [uid];
}

class GetWithoutLoadingSlot extends DigitalEvent{
  final String uid;

  const GetWithoutLoadingSlot({required this.uid});
  @override
  List<Object> get props => [uid];
}

class BookSlot extends DigitalEvent{
  final List<dynamic> list;
  final String docId;
  final String uid;
  const BookSlot({required this.docId, required this.uid, required this.list});
  @override
  List<Object> get props => [list,docId,uid];
}
