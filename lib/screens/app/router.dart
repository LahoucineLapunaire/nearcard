import 'package:NearCard/blocs/router/router_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouterScreen extends StatelessWidget {
  const RouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouterBloc, RouterInitial>(
      builder: (context, state) {
        return Scaffold(
            body: state.pages[state.currentPage],
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomNavigationBar(
                  selectedItemColor: const Color(0xff001f3f),
                  currentIndex: state.currentPage,
                  onTap: (index) {
                    context
                        .read<RouterBloc>()
                        .add(RouterChangePage(context, index));
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Accueil',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Recherche',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profil',
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}
