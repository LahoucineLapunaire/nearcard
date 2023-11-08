import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/blocs/visited_user/visited_user_bloc.dart';
import 'package:NearCard/screens/app/visitedUser.dart';
import 'package:NearCard/utils/QrCode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:share_plus/share_plus.dart';

final auth = firebase_auth.FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CurrentUserNotFound) {
          return const Center(child: Text("Utilisateur non trouvé"));
        }
        if (state is CurrentUserLoaded) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          QRCodeScreen()), // Navigate to the QR code screen
                );
              },
              child: Icon(FontAwesomeIcons
                  .qrcode), // Utilisez l'icône QR Code de font_awesome_flutter
            ),
            appBar: AppBar(
              backgroundColor: Color(0xff001f3f),
              title: Text("Cartes reçues"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.currentUser?.uid)
                    .snapshots(), // Remplacez par votre propre stream
                builder: (context, snapshot) {
                  final List<dynamic>? receivedCards =
                      snapshot.data?.get('cardReceived');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Affichez un indicateur de chargement en attendant les données.
                  } else if (snapshot.hasError) {
                    return Text("Erreur : ${snapshot.error}");
                  } else if (receivedCards!.isEmpty) {
                    return Center(child: Text("Aucune carte reçue."));
                  } else {
                    return ListView.builder(
                      itemCount: receivedCards.length,
                      itemBuilder: (context, index) {
                        return DelayedDisplay(
                          delay: Duration(milliseconds: 100 + (index * 100)),
                          child: BusinessCard(
                            visitedUserId: receivedCards[index]['sender'],
                            date: receivedCards[index]['date'],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class BusinessCard extends StatelessWidget {
  final String visitedUserId;
  final Timestamp date;

  const BusinessCard({
    super.key,
    required this.visitedUserId,
    required this.date,
  });

  String formatTimestamp(Timestamp timestamp) {
    if (timestamp == null) {
      return "Date inconnue";
    }
    final dateTime = timestamp.toDate();
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year
        .toString()
        .substring(2); // Les deux derniers chiffres de l'année
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$day/$month/$year - $hour:$minute';
  }

  Future<String?> getCityFromGeoPoint(GeoPoint geoPoint) async {
    try {
      // Obtenez les informations de localisation à partir des coordonnées du GeoPoint
      List<Placemark> placemarks = await placemarkFromCoordinates(
        geoPoint.latitude,
        geoPoint.longitude,
      );

      // Récupérez la ville à partir des informations de localisation
      if (placemarks.isNotEmpty) {
        String city = placemarks[0].locality ?? 'Ville inconnue';
        return city;
      } else {
        return 'Ville inconnue';
      }
    } catch (e) {
      print("Erreur lors de la récupération de la ville : $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitedUserBloc(visitedUserId),
      child: BlocBuilder<VisitedUserBloc, VisitedUserState>(
        builder: (context, state) {
          if (state is VisitedUserInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VisitedUserNotFound) {
            return const Center(child: Text("Utilisateur non trouvé"));
          }
          if (state is VisitedUserLoaded) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VisitedUserScreen(
                              visitedUser: state.visitedUser,
                            )));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),
                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        firestore
                            .collection('users')
                            .doc(auth.currentUser?.uid)
                            .update({
                          'cardReceived': FieldValue.arrayRemove([
                            {
                              'sender': visitedUserId,
                              'receiver': auth.currentUser?.uid,
                              'date': date,
                            }
                          ])
                        });
                      },
                    ),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) {
                          firestore
                              .collection('users')
                              .doc(auth.currentUser?.uid)
                              .update({
                            'cardReceived': FieldValue.arrayRemove([
                              {
                                'sender': visitedUserId,
                                'receiver': auth.currentUser?.uid,
                                'date': date,
                              }
                            ])
                          });
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          Share.share(
                            'https://nearcard.com/users/${visitedUserId}',
                          );
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Color(int.parse(state.visitedUser.bgColor)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(
                                      int.parse(state.visitedUser.textColor)),
                                  width: 2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: state.visitedUser.picture == ""
                                    ? Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.userPlus,
                                          size: 40,
                                          color: Color(int.parse(
                                              state.visitedUser.textColor)),
                                        ),
                                      )
                                    : Image.network(
                                        state.visitedUser.picture,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.visitedUser.name} ${state.visitedUser.prename}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(
                                        int.parse(state.visitedUser.textColor)),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  state.visitedUser.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(
                                        int.parse(state.visitedUser.textColor)),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.visitedUser.company,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(int.parse(
                                                state.visitedUser.textColor)),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                    Text(formatTimestamp(date),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Color(int.parse(
                                              state.visitedUser.textColor)),
                                          fontFamily: 'Montserrat',
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
