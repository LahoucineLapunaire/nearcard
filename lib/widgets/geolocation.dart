import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

void sceduleCardSharing() async {
  try {
    print("start sceduleCardSharing");
    final cron = Cron();
    DateTime startedTime = DateTime.now();
    cron.schedule(Schedule.parse('*/1 * * * *'), () async {
      manageCardSharing();
      final DateTime currentTime = DateTime.now();
      final Duration elapsed = currentTime.difference(startedTime);
      if (elapsed.inMinutes >= 30) {
        stopCardShare();
        cron.close();
        return;
      }
    });
  } catch (e) {
    print(e.toString());
  }
}

void manageCardSharing() async {
  try {
    //get position
    Position position = await getPosition();

    // set position in firestore
    sendLocation(position);

    // get people nearby
    List<QueryDocumentSnapshot<Object?>> peopleNearby =
        await getPeopleNearby(position);

    // send card to people nearby if cardShare is true
    sendPeopleNearby(peopleNearby, position);
  } catch (e) {
    print(e.toString());
  }
}

void stopCardShare() async {
  try {
    print("start stopCardShare");
    firestore.collection('users').doc(auth.currentUser?.uid).update({
      'cardShare': false,
    });
  } catch (e) {
    print(e.toString());
  }
}

void sendLocation(Position position) async {
  try {
    print("start sendLocation");
    firestore.collection('users').doc(auth.currentUser?.uid).update({
      'cardShare': true,
      'location': GeoPoint(position.latitude, position.longitude),
    });
  } catch (e) {
    print(e.toString());
  }
}

Future<Position> getPosition() async {
  try {
    final PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.permanentlyDenied) {
      print("Permission denied");
      return Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0);
    }
    print("start getPosition");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  } catch (e) {
    print(e.toString());
    return Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0);
  }
}

// Future<Position> getPosition()
Future<List<QueryDocumentSnapshot<Object?>>> getPeopleNearby(
    Position position) async {
  try {
    print("start getPeopleNearby");
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Créez les bornes pour la requête géospatiale
    GeoPoint lowerBound = GeoPoint(latitude - 0.01, longitude - 0.01);
    GeoPoint upperBound = GeoPoint(latitude + 0.01, longitude + 0.01);
    print("before querySnapshot");
    // Utilisez les bornes pour effectuer la requête Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('location', isGreaterThanOrEqualTo: lowerBound)
        .where('location', isLessThanOrEqualTo: upperBound)
        .get();
    print("after querySnapshot");
    return querySnapshot.docs;
  } catch (e) {
    print(e.toString());
    return [];
  }
}

void sendPeopleNearby(
    List<QueryDocumentSnapshot<Object?>> peopleNearby, Position position) {
  try {
    print("start sendPeopleNearby");

    for (QueryDocumentSnapshot<Object?> doc in peopleNearby) {
      Map<String, dynamic> data = {
        "sender": auth.currentUser?.uid,
        "receiver": doc.id,
        "date": DateTime.now(),
        "location": GeoPoint(position.latitude, position.longitude),
      };
      firestore.collection('users').doc(auth.currentUser?.uid).update({
        "cardSent": FieldValue.arrayUnion([data]), // add doc.id to array
      });
      firestore.collection('users').doc(doc.id).update({
        "cardReceived": FieldValue.arrayUnion([data]),
      });
    }

    print("finish");
  } catch (e) {
    print(e.toString());
  }
}
