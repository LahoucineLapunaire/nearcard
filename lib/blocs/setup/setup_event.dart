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
