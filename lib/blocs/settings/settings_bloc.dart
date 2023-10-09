import 'package:NearCard/model/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
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
        emit(SettingsLoaded(currentUser, true));
      } else {
        // Le document n'existe pas (l'utilisateur n'a peut-être pas encore été créé)
        // Vous pouvez choisir de gérer cela différemment selon votre logique
        emit(SettingsNotFound());
      }
    });
    on<SettingsEvent>((event, emit) async {
      // Le reste de votre gestion d'événements

      if (event is SettingsEventChangeNotification) {
        SettingsLoaded settingsState = state as SettingsLoaded;
        settingsState =
            settingsState.copyWith(notification: event.notification);
        emit(settingsState);
      }
      if (event is SettingsEventChangeUserinfo) {
        // Récupérer l'utilisateur courant
        final SettingsLoaded settingsState = state as SettingsLoaded;
        final CurrentUser currentUser = settingsState.currentUser;

        // Mettre à jour le champ notification
        firestore
            .collection("users")
            .doc(auth.currentUser?.uid)
            .update({event.field: event.value});
        currentUser.setField(event.field, event.value);
        emit(settingsState.copyWith(currentUser: currentUser));
      }
    });
  }
}
