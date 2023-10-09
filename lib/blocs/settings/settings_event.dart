part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsEventChangeNotification extends SettingsEvent {
  bool notification;

  SettingsEventChangeNotification({required this.notification});
}

class SettingsEventChangeUserinfo extends SettingsEvent {
  String field;
  String value;

  SettingsEventChangeUserinfo({required this.field, required this.value});
}
