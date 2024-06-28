part of 'subject_bloc.dart';

abstract class SubjectEvent {
  const SubjectEvent();
}

class GetSubjectsEvent extends SubjectEvent {}

class AddSubjectsEvent extends SubjectEvent {
  final String title;
  final String description;
  AddSubjectsEvent({
    required this.title,
    required this.description,
  });
}
