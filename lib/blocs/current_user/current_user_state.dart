part of 'current_user_bloc.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoaded extends CurrentUserState {
  final CurrentUser currentUser;
  final bool recto;

  CurrentUserLoaded(this.currentUser, this.recto);

  CurrentUserLoaded copyWith({
    CurrentUser? currentUser,
    bool? recto,
  }) {
    return CurrentUserLoaded(
      currentUser ?? this.currentUser,
      recto ?? this.recto,
    );
  }
}

class CurrentUserNotFound extends CurrentUserState {}
