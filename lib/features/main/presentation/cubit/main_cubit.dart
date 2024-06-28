import 'package:bloc/bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());
  changeIndex(int index) {
    if (state.index != index) {
      emit(state.copyWith(index: index));
    }
  }
}
