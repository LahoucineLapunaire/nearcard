part of 'router_bloc.dart';

@immutable
sealed class RouterState {}

final class RouterInitial extends RouterState {
  List<Widget> pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
  int currentPage = 0;

  RouterInitial(this.currentPage);
}
