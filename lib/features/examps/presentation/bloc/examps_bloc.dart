import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';
import 'package:school_daashboard/core/utils/toaster.dart';

import '../../data/models/exam_model.dart';

part 'examps_event.dart';
part 'examps_state.dart';

class ExampsBloc extends Bloc<ExampsEvent, ExampsState> {
  ExampsBloc() : super(const ExampsState()) {
    on<GetExampsEvent>((event, emit) async {
      emit(state.copyWith(indexStatus: CubitStatus.loading));
      try {
        final result = await GetApi<IndexExampsModel>(
                uri: ApiVariables().exams(), fromJson: indexExampsModelFromJson)
            .callRequest();
        if (result.data!.isNotEmpty) {
          emit(state.copyWith(
              exams: result.data, indexStatus: CubitStatus.success));
        }
      } on Exception catch (e) {
        emit(state.copyWith(indexStatus: CubitStatus.failed));
      }
    });
    on<AddExamEvent>((event, emit) async {
      Toaster.showLoading();
      try {
        final result = await PostApi(
                uri: ApiVariables().examsAdd(),
                body: event.body,
                fromJson: (s) {})
            .callRequest();
        Toaster.closeLoading();
        add(GetExampsEvent());
      } on Exception catch (e) {
        Toaster.closeLoading();
        Toaster.showToast('There Is An Error');
      }
    });
  }
}
