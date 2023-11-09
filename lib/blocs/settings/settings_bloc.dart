import 'dart:io';
import 'package:NearCard/model/user.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;

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
        emit(SettingsLoaded(
            currentUser, true, "", currentUser.bgColor, currentUser.textColor));
      } else {
        // Le document n'existe pas (l'utilisateur n'a peut-être pas encore été créé)
        // Vous pouvez choisir de gérer cela différemment selon votre logique
        emit(SettingsNotFound());
      }
    });
    on<SettingsEvent>((event, emit) async {
      // Le reste de votre gestion d'événements

      if (event is SettingsEventChangeNotification) {
        //set shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("notification", event.notification);

        //set subscription

        FirebaseMessaging messaging = FirebaseMessaging.instance;
        if (event.notification) {
          messaging.subscribeToTopic("general");
          messaging.subscribeToTopic(auth.currentUser!.uid);
        } else {
          messaging.unsubscribeFromTopic("general");
          messaging.unsubscribeFromTopic(auth.currentUser!.uid);
        }

        SettingsLoaded settingsState = state as SettingsLoaded;
        settingsState =
            settingsState.copyWith(notification: event.notification);
        emit(settingsState);
      }
      if (event is SettingsEventChangeUserinfo) {
        try {
          if (event.field == "picture") {
            String downloadURL = "";
            Reference imageRef;

            Reference webStorageRef =
                storage.refFromURL("gs://nearcard-fa985.appspot.com/users");
            Reference storageRef = storage.ref("users");

            if (kIsWeb) {
              // Set the image reference for web
              imageRef = webStorageRef.child("${auth.currentUser!.uid}.jpg");
            } else {
              // Set the image reference for mobile
              imageRef = storageRef.child("${auth.currentUser!.uid}.jpg");
            }
            UploadTask uploadTask;
            if (kIsWeb) {
              // Upload image data for web
              Uint8List imageData = await XFile(event.value).readAsBytes();
              uploadTask = imageRef.putData(imageData);
            } else {
              // Upload image file for mobile
              uploadTask = imageRef.putFile(File(event.value));
            }
            await uploadTask.whenComplete(() async {
              downloadURL = await imageRef.getDownloadURL();
            });
            final SettingsLoaded settingsState = state as SettingsLoaded;
            final CurrentUser currentUser = settingsState.currentUser;

            // Mettre à jour le champ notification
            firestore
                .collection("users")
                .doc(auth.currentUser?.uid)
                .update({event.field: downloadURL});
            currentUser.setField(event.field, downloadURL);
            emit(settingsState.copyWith(currentUser: currentUser));
            displayMessage(event.context, "Votre profil a été mis à jour !");
            Navigator.pop(event.context);
            return;
          }
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
          displayMessage(event.context, "Votre profil a été mis à jour !");
          Navigator.pop(event.context);
        } catch (e) {
          displayMessage(event.context,
              "Une erreur est survenue lors de la mise à jour de votre profil.");
        }
      }
      if (event is SettingsEventTakePicture) {
        final ImagePicker picker = ImagePicker();
        // Pick an image.
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          SettingsLoaded settingsState = state as SettingsLoaded;
          settingsState = settingsState.copyWith(
            picture: image.path,
          );
          emit(settingsState);
        } else {
          displayError(event.context, "Veuillez choisir une image");
        }
      }
      if (event is SettingsEventChangeBgColor) {
        SettingsLoaded settingsState = state as SettingsLoaded;
        settingsState = settingsState.copyWith(bgColor: "0x${event.color}");
        emit(settingsState);
      }
      if (event is SettingsEventChangeTextColor) {
        SettingsLoaded settingsState = state as SettingsLoaded;
        settingsState = settingsState.copyWith(textColor: "0x${event.color}");
        emit(settingsState);
      }
    });
  }
}
