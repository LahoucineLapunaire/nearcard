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
