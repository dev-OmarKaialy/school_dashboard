part of 'section_bloc.dart';

abstract class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object> get props => [];
}

class IndexSectionsEvent extends SectionEvent {}

class DeleteSectionEvent extends SectionEvent {
  final int id;
  const DeleteSectionEvent({
    required this.id,
  });
}

class AddSectionEvent extends SectionEvent {
  final BodyMap body;
  const AddSectionEvent({
    required this.body,
  });
}

class UpdateSectionEvent extends SectionEvent {
  final int id;

  final BodyMap body;
  const UpdateSectionEvent({
    required this.id,
    required this.body,
  });
}
