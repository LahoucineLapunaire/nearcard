import 'package:NearCard/blocs/visited_user/visited_user_bloc.dart';
import 'package:NearCard/screens/app/visitedUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  final String visitedUserId;
  const UserPage({super.key, required this.visitedUserId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitedUserBloc(visitedUserId),
      child: BlocBuilder<VisitedUserBloc, VisitedUserState>(
        builder: (context, state) {
          if (state is VisitedUserInitial) {
            return const Scaffold(
              backgroundColor: Color(0xFF001F3F),
              body: Center(
                child: Text(
                  "Chargement de l'utilisateur...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          if (state is VisitedUserNotFound) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('NearCard'),
              ),
              body: const Center(
                child: Text("L'utilisateur n'a pas été trouvé"),
              ),
            );
          }
          if (state is VisitedUserLoaded) {
            return VisitedUserScreen(visitedUser: state.visitedUser);
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('NearCard'),
            ),
            body: const Center(
              child: Text("L'utilisateur n'a pas été trouvé"),
            ),
          );
        },
      ),
    );
  }
}
