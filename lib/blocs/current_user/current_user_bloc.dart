import 'package:NearCard/model/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc() : super(CurrentUserInitial()) {
    // Récupérer l'ID de l'utilisateur courant
    final String currentUserId = auth.currentUser?.uid ?? '';

    // Écouter les changements dans le document Firestore de l'utilisateur courant
    firestore
        .collection("users")
        .doc(currentUserId)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        // Le document existe, donc nous pouvons le traiter
        final userData = event.data() as Map<String, dynamic>;
        final currentUser = CurrentUser.fromJson(userData);
        // Émettre un nouvel état avec les données de l'utilisateur courant
        emit(CurrentUserLoaded(currentUser));
      } else {
        // Le document n'existe pas (l'utilisateur n'a peut-être pas encore été créé)
        // Vous pouvez choisir de gérer cela différemment selon votre logique
        emit(CurrentUserNotFound());
      }
    });

    on<CurrentUserEvent>((event, emit) {
      // Le reste de votre gestion d'événements

      if (event is CurrentUserChangeShare) {
        CurrentUserLoaded state = this.state as CurrentUserLoaded;
        final currentUser = state.currentUser;
        currentUser.cardShare = event.share;
        emit(CurrentUserLoaded(currentUser));
      }
    });
  }
}
