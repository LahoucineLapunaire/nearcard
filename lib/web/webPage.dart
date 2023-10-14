import 'dart:async';

import 'package:NearCard/blocs/visited_user/visited_user_bloc.dart';
import 'package:NearCard/model/user.dart';
import 'package:NearCard/screens/app/visitedUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
VisitedUser empty = VisitedUser(
    uid: "",
    email: "",
    name: "",
    prename: "",
    title: "",
    company: "",
    number: "",
    address: "",
    linkedin: "",
    website: "",
    picture: "",
    bgColor: "",
    textColor: "");

final currentUrl = html.window.location.href;
final uri = Uri.parse(currentUrl);

// Accédez aux paramètres de requête en utilisant uri.queryParameters
final parameterValue = uri.queryParameters['userId'];

Future<VisitedUser> getVisitedUser() async {
  try {
    if (parameterValue == null || parameterValue == "") {
      return empty;
    }
    VisitedUser user = empty;
    firestore
        .collection("users")
        .doc(parameterValue)
        .snapshots()
        .listen((event) async {
      if (event.exists) {
        // Le document existe, donc nous pouvons le traiter
        final userData = event.data() as Map<String, dynamic>;
        userData['email'] =
            await getEmailFromUID(parameterValue!).then((value) {
          if (value != null) {
            return value;
          } else {
            return "";
          }
        });
        userData['uid'] = parameterValue;
        final visitedUser = VisitedUser.fromJson(userData);
        user = visitedUser;
      }
    });
    return user;
  } catch (e) {
    print("Erreur lors de la récupération de l'utilisateur : $e");
    return empty;
  }
}

Future<String?> getEmailFromUID(String uid) async {
  try {
    User? user = await FirebaseAuth.instance.userChanges().firstWhere((user) {
      return user?.uid == uid;
    });
    if (user != null) {
      return user.email;
    } else {
      // L'utilisateur n'a pas été trouvé
      return null;
    }
  } catch (e) {
    print("Erreur lors de la récupération de l'email : $e");
    return null;
  }
}

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Web Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: FutureBuilder(
                future: getVisitedUser(),
                builder: (builder, snapshot) {
                  if (snapshot.hasData) {
                    var visitedUser = snapshot.data ?? empty;
                    if (snapshot.data == empty) {
                      return Center(child: Text("L'utilisateur n'existe pas"));
                    } else {
                      return VisitedUserScreen(visitedUser: visitedUser);
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
