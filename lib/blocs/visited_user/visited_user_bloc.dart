import 'package:NearCard/model/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'visited_user_event.dart';
part 'visited_user_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class VisitedUserBloc extends Bloc<VisitedUserEvent, VisitedUserState> {
  final String visitedUserId;

  VisitedUserBloc(this.visitedUserId)
      : super(VisitedUserInitial(visitedUserId)) {
    // Écouter les changements dans le document Firestore de l'utilisateur courant
    firestore
        .collection("users")
        .doc(visitedUserId)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        // Le document existe, donc nous pouvons le traiter
        final userData = event.data() as Map<String, dynamic>;
        final visitedUser = VisitedUser.fromJson(userData);

        // Émettre un nouvel état avec les données de l'utilisateur courant
        emit(VisitedUserLoaded(visitedUser));
      } else {
        // Le document n'existe pas (l'utilisateur n'a peut-être pas encore été créé)
        // Vous pouvez choisir de gérer cela différemment selon votre logique
        emit(VisitedUserNotFound());
      }
    });
    on<VisitedUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}