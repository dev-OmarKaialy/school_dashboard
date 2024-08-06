part of 'type_bloc.dart';

abstract class TypeEvent {
  const TypeEvent();
}

class IndexTypesEvent extends TypeEvent {}

class DeleteTypeEvent extends TypeEvent {
  final int id;
  DeleteTypeEvent({
    required this.id,
  });
}

class UpdateTypeEvent extends TypeEvent {
  final int id;
  final int totalAmount;
  UpdateTypeEvent({
    required this.id,
    required this.totalAmount,
  });
}

class AddTypeEvent extends TypeEvent {
  final String name;
  final String description;
  final int totalAmount;
  AddTypeEvent({
    required this.name,
    required this.description,
    required this.totalAmount,
  });
}

class AssignTypeToSection extends TypeEvent {
  final int id;
  final int sid;

  AssignTypeToSection({required this.id, required this.sid});
}

class AddHomeWorkEvent extends TypeEvent {
  final String text;
  final String endDate;
  final int teacherId;
  final int typeSectionId;
  AddHomeWorkEvent({
    required this.text,
    required this.endDate,
    required this.teacherId,
    required this.typeSectionId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'end_date': endDate});
    result.addAll({'teacher_id': teacherId});
    result.addAll({'type_section_id': typeSectionId});

    return result;
  }
}
