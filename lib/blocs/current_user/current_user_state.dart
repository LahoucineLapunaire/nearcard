part of 'current_user_bloc.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoaded extends CurrentUserState {
  final CurrentUser currentUser;

  CurrentUserLoaded(this.currentUser);

  CurrentUserLoaded copyWith({
    CurrentUser? currentUser,
  }) {
    return CurrentUserLoaded(
      currentUser ?? this.currentUser,
    );
  }
}

class CurrentUserNotFound extends CurrentUserState {}
