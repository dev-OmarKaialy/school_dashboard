part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class SendNotification extends NotificationEvent {
  final String title;
  final String description;
  final String target;
  const SendNotification({
    required this.title,
    required this.description,
    required this.target,
  });
}
