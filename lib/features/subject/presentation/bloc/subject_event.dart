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

class UpdateSubjectsEvent extends SubjectEvent {
  final int id;
  final String title;
  final String description;
  UpdateSubjectsEvent({
    required this.id,
    required this.title,
    required this.description,
  });
}

class DeleteSubjectEvent extends SubjectEvent {
  final int id;
  DeleteSubjectEvent({
    required this.id,
  });
}

class ShowSubjectEvent extends SubjectEvent {
  final int id;
  ShowSubjectEvent({
    required this.id,
  });
}
