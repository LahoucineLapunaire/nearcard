import 'dart:async';
import 'package:NearCard/model/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'visited_user_event.dart';
part 'visited_user_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFunctions functions =
    FirebaseFunctions.instanceFor(region: 'europe-west3');

Future<String?> getEmailFromUid(String uid) async {
  try {
    User? user = await FirebaseAuth.instance
        .userChanges()
        .firstWhere((user) => user?.uid == uid);
    if (user != null) {
      return user.email;
    } else {
      // L'utilisateur n'a pas été trouvé
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<String?> getEmailFromUidWeb(String uid) async {
  try {
    final dynamic result =
        await functions.httpsCallable('getEmailFromUid').call({"uid": uid});
    final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
    return jsonData["email"]["email"];
  } catch (e) {
    return null;
  }
}

class VisitedUserBloc extends Bloc<VisitedUserEvent, VisitedUserState> {
  final String visitedUserId;
  StreamSubscription<DocumentSnapshot>? _subscription;

  VisitedUserBloc(this.visitedUserId)
      : super(VisitedUserInitial(visitedUserId)) {
    // Écouter les changements dans le document Firestore de l'utilisateur courant

    _subscription = firestore
        .collection("users")
        .doc(visitedUserId)
        .snapshots()
        .listen((event) async {
      if (event.exists) {
        String email = "";
        email = await getEmailFromUidWeb(visitedUserId) ?? "";
        final userData = event.data() as Map<String, dynamic>;
        userData['email'] = email;
        userData['uid'] = visitedUserId;

        final visitedUser = VisitedUser.fromJson(userData);
        // Émettre un nouvel état avec les données de l'utilisateur courant
        if (!isClosed) {
          emit(VisitedUserLoaded(visitedUser));
        }
      } else {
        // Le document n'existe pas (l'utilisateur n'a peut-être pas encore été créé)
        // Vous pouvez choisir de gérer cela différemment selon votre logique
        if (!isClosed) {
          emit(VisitedUserNotFound());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
