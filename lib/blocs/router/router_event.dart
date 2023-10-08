part of 'router_bloc.dart';

@immutable
sealed class RouterEvent {}

final class RouterChangePage extends RouterEvent {
  int index;

  RouterChangePage(this.index);
}
