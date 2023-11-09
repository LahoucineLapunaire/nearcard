part of 'current_user_bloc.dart';

sealed class CurrentUserEvent {}

class CurrentUserChangeShare extends CurrentUserEvent {
  final bool share;

  CurrentUserChangeShare({required this.share});
}
