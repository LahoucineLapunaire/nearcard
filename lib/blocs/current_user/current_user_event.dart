part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserShareCard extends CurrentUserEvent {
  bool share;

  CurrentUserShareCard({required this.share});
}
