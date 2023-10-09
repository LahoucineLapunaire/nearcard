part of 'settings_bloc.dart';

abstract class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final CurrentUser currentUser;
  final bool notification;

  SettingsLoaded(this.currentUser, this.notification);

  SettingsLoaded copyWith({
    CurrentUser? currentUser,
    bool? notification,
  }) {
    return SettingsLoaded(
      currentUser ?? this.currentUser,
      notification ?? this.notification,
    );
  }
}

final class SettingsNotFound extends SettingsState {}
