import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  ProgramsBloc() : super(ProgramsInitial()) {
    on<ProgramsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
