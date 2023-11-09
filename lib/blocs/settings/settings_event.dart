part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class SettingsEventChangeNotification extends SettingsEvent {
  bool notification;

  SettingsEventChangeNotification({required this.notification});
}

class SettingsEventChangeUserinfo extends SettingsEvent {
  BuildContext context;
  String field;
  String value;

  SettingsEventChangeUserinfo(
      {required this.context, required this.field, required this.value});
}

class SettingsEventTakePicture extends SettingsEvent {
  final BuildContext context;

  SettingsEventTakePicture(this.context);
}

class SettingsEventChangeBgColor extends SettingsEvent {
  final String color;

  SettingsEventChangeBgColor(this.color);
}

class SettingsEventChangeTextColor extends SettingsEvent {
  final String color;

  SettingsEventChangeTextColor(this.color);
}
