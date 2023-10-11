part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserChangeShare extends CurrentUserEvent {
  final bool share;

  CurrentUserChangeShare({required this.share});

  @override
  List<Object> get props => [share];
}
