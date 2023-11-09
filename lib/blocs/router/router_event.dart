part of 'router_bloc.dart';

sealed class RouterEvent {}

final class RouterChangePage extends RouterEvent {
  BuildContext context;
  int index;

  RouterChangePage(this.context, this.index);
}
