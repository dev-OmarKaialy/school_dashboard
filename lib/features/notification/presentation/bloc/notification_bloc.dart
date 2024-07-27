import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/users/data/repositories/user_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<SendNotification>((event, emit) async {
      Toaster.showLoading();
      final result = await UserRepo().sendNotification({
        // 'user_id': 1,
        'title': event.title,
        'message': event.description,
        'deviceToken': event.target,
      });
      result.fold((l) {
        Toaster.showToast('حدث خطأ', isError: true);
      }, (r) {
        Toaster.showToast('تم الارسال بنجاح');
        emit(const NotificationState());
      });
      Toaster.closeLoading();
    });
  }
}
