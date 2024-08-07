part of 'examps_bloc.dart';

abstract class ExampsEvent extends Equatable {
  const ExampsEvent();

  @override
  List<Object> get props => [];
}

class GetExampsEvent extends ExampsEvent {}

class AddExamEvent extends ExampsEvent {
  final BodyMap body;
  const AddExamEvent({
    required this.body,
  });
}
