part of 'router_bloc.dart';

sealed class RouterState {}

final class RouterInitial extends RouterState {
  List<dynamic> pages = [
    const HomeScreen(),
    const Text(""),
    const ProfileScreen(),
  ];
  int currentPage = 0;

  RouterInitial(this.currentPage);
}
