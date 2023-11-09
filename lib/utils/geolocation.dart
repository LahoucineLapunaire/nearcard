import 'dart:async';
import 'package:NearCard/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<CurrentUser> currentUser = firestore
    .collection("users")
    .doc(auth.currentUser?.uid)
    .get()
    .then((value) {
  return CurrentUser.fromJson(value.data()!);
});

/*
//--------------------------------------------------------------

void setupCardSharing() {
  BackgroundFetch.stop();
  Location location = Location();
  location.enableBackgroundMode(enable: true);
  var config = BackgroundFetchConfig(
    minimumFetchInterval: 15, // Intervalle minimum en minutes
    stopOnTerminate:
        false, // Pour continuer à s'exécuter après la fermeture de l'application
    enableHeadless: true, // Activer le traitement en arrière-plan
    forceAlarmManager:
        true, // Utiliser AlarmManager sur Android pour une précision maximale
  );

  BackgroundFetch.configure(config, (String taskId) async {});
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  BackgroundFetch.scheduleTask(
    TaskConfig(
      taskId: 'flutter_background_fetch',
      delay: 2 * 60 * 1000, // Délai en millisecondes (15 minutes)
      periodic: true, // Tâche périodique
      stopOnTerminate:
          false, // Continuer à s'exécuter après la fermeture de l'application
      enableHeadless: true, // Activer le traitement en arrière-plan
      forceAlarmManager:
          true, // Utiliser AlarmManager sur Android pour une précision maximale
    ),
  );
}

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (taskId == 'flutter_background_fetch') {
    // Appel de votre fonction de partage de carte ici
    // Exécutez votre code ici en arrière-plan
    // N'oubliez pas d'appeler manageCardSharingWithPosition
    // lorsque vous recevez une nouvelle position.
    await scheduleCardSharing();
  }
  if (isTimeout) {
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    BackgroundFetch.finish(taskId);
    return;
  }
  BackgroundFetch.finish(taskId);
}

void stopBackgroundFetch() {
  BackgroundFetch.stop();
}

Future<void> scheduleCardSharing() async {
  try {
    //get position
    /*
    
     */
    /*
    geo.Position position = await geo.Geolocator.getCurrentPosition(
            forceAndroidLocationManager: false,
            desiredAccuracy: geo.LocationAccuracy.high)
        .then((value) {
      print("then : " + value.toString());
      return value;
    }).catchError((error) {
      print("catchError : " + error.toString());
      return null;
    });
    LocationData locationData = LocationData.fromMap({
      "latitude": position.latitude,
      "longitude": position.longitude,
    });
    print("position : " + position.toString());
    */
    Location location = Location();

    location.enableBackgroundMode(enable: true);
    LocationData position = await location.getLocation();
    manageCardSharingWithPosition(position);
  } catch (e) {}
}

Future<void> manageCardSharingWithPosition(LocationData position) async {
  try {
    // set position in firestore
    sendLocation(position);

    // get people nearby
    List<QueryDocumentSnapshot<Object?>> peopleNearby =
        await getPeopleNearby(position);

    // send card to people nearby if cardShare is true
    sendPeopleNearby(peopleNearby, position);
  } catch (e) {}
}

Future<void> stopCardShare() async {
  try {
    firestore.collection('users').doc(auth.currentUser?.uid).update({
      'cardShare': false,
    });
  } catch (e) {}
}

Future<void> sendLocation(LocationData position) async {
  try {
    firestore.collection('users').doc(auth.currentUser?.uid).update({
      'cardShare': true,
      'location': GeoPoint(position.latitude ?? 0, position.longitude ?? 0),
    });
  } catch (e) {}
}

// Future<Position> getPosition()
Future<List<QueryDocumentSnapshot<Object?>>> getPeopleNearby(
    LocationData position) async {
  try {
    double latitude = position.latitude ?? 0;
    double longitude = position.longitude ?? 0;

    // Créez les bornes pour la requête géospatiale
    GeoPoint lowerBound = GeoPoint(latitude - 0.01, longitude - 0.01);
    GeoPoint upperBound = GeoPoint(latitude + 0.01, longitude + 0.01);
    // Utilisez les bornes pour effectuer la requête Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('location', isGreaterThanOrEqualTo: lowerBound)
        .where('location', isLessThanOrEqualTo: upperBound)
        .get();
    return querySnapshot.docs;
  } catch (e) {
    return [];
  }
}

Future<void> sendPeopleNearby(List<QueryDocumentSnapshot<Object?>> peopleNearby,
    LocationData position) async {
  try {
    for (QueryDocumentSnapshot<Object?> doc in peopleNearby) {
      Map<String, dynamic> data = {
        "sender": auth.currentUser?.uid,
        "receiver": doc.id,
        "date": DateTime.now(),
        "location": GeoPoint(position.latitude ?? 0, position.longitude ?? 0),
      };
      CurrentUser user = await currentUser;
      /* Verification
      if (doc.id == auth.currentUser?.uid) {
        continue;
      }
      if (user.cardShare == false) {
        continue;
      }
      List<Map<String, dynamic>> cardReceived = doc.get("cardReceived");
      bool alreadyReceived =
          cardReceived.any((map) => map['sender'] == auth.currentUser?.uid);
      if (alreadyReceived) {
        continue;
      }
    */
      sendNotificationToTopic(
          doc.id,
          "Carte de visite reçue !",
          "${user.name} ${user.prename} vous a envoyé sa carte de visite !",
          user.picture, {
        "sender": auth.currentUser!.uid,
        "receiver": doc.id,
        "type": "card",
        "click_action": "FLUTTER_card_CLICK",
      });
      firestore.collection('users').doc(auth.currentUser?.uid).update({
        "cardSent": FieldValue.arrayUnion([data]), // add doc.id to array
      });
      firestore.collection('users').doc(doc.id).update({
        "cardReceived": FieldValue.arrayUnion([data]),
      });
    }
    BackgroundFetch.finish("");
  } catch (e) {}
}
*/