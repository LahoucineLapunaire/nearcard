part of 'setup_bloc.dart';

@immutable
sealed class SetupEvent {}

class SetupEventChange extends SetupEvent {
  final int page;

  SetupEventChange(this.page);
}

class SetupEventTakePicture extends SetupEvent {
  final BuildContext context;

  SetupEventTakePicture(this.context);
}

class SetupEventChangeBgColor extends SetupEvent {
  final String color;

  SetupEventChangeBgColor(this.color);
}

class SetupEventChangeTextColor extends SetupEvent {
  final String color;

  SetupEventChangeTextColor(this.color);
}

class SetupEventFirstSetup extends SetupEvent {
  final BuildContext context;
  final String name;
  final String prename;
  final String title;
  final String company;
  final String number;
  final String address;
  final String linkedin;
  final String website;
  final String picture;
  final String bgColor;
  final String textColor;

  SetupEventFirstSetup(
      this.context,
      this.name,
      this.prename,
      this.title,
      this.company,
      this.number,
      this.address,
      this.linkedin,
      this.website,
      this.picture,
      this.bgColor,
      this.textColor);
}
