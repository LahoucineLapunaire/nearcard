part of 'settings_bloc.dart';

abstract class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final CurrentUser currentUser;
  final bool notification;

  TextEditingController nameController = TextEditingController();
  TextEditingController prenameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  String picture = "";
  String bgColor = "";
  String textColor = "";

  SettingsLoaded(this.currentUser, this.notification, this.picture,
      this.bgColor, this.textColor);

  SettingsLoaded copyWith({
    CurrentUser? currentUser,
    bool? notification,
    String? picture,
    String? bgColor,
    String? textColor,
  }) {
    return SettingsLoaded(
      currentUser ?? this.currentUser,
      notification ?? this.notification,
      picture ?? this.picture,
      bgColor ?? this.bgColor,
      textColor ?? this.textColor,
    );
  }
}

final class SettingsNotFound extends SettingsState {}
