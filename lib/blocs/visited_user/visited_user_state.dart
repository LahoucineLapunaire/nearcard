part of 'visited_user_bloc.dart';

abstract class VisitedUserState {}

final class VisitedUserInitial extends VisitedUserState {
  String visitedUserId;

  VisitedUserInitial(this.visitedUserId);
}

final class VisitedUserLoaded extends VisitedUserState {
  final VisitedUser visitedUser;

  VisitedUserLoaded(this.visitedUser);

  VisitedUserLoaded copyWith({
    VisitedUser? visitedUser,
  }) {
    return VisitedUserLoaded(
      visitedUser ?? this.visitedUser,
    );
  }
}

final class VisitedUserNotFound extends VisitedUserState {}
