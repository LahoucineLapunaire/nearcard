import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/blocs/visited_user/visited_user_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

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
                          delay: Duration(milliseconds: 400 + (index * 100)),
                          child: BusinessCard(
                            visitedUserId: receivedCards[index]['sender'],
                            date: receivedCards[index]['date'],
                            location: receivedCards[index]['location'],
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
  final GeoPoint location;

  const BusinessCard(
      {super.key,
      required this.visitedUserId,
      required this.date,
      required this.location});

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
            return Container(
              margin: EdgeInsets.only(bottom: 15),
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
                            color:
                                Color(int.parse(state.visitedUser.textColor)),
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
                                    color: Color(
                                        int.parse(state.visitedUser.textColor)),
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
                              color:
                                  Color(int.parse(state.visitedUser.textColor)),
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
                              color:
                                  Color(int.parse(state.visitedUser.textColor)),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.locationDot,
                                      size: 14,
                                      color: Color(int.parse(
                                          state.visitedUser.textColor))),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  FutureBuilder<String?>(
                                    future: getCityFromGeoPoint(location),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // Pendant que la future est en cours de chargement, affichez un indicateur de chargement par exemple.
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        // En cas d'erreur, affichez un message d'erreur.
                                        return Text(
                                            'Erreur: ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        // Si la future a renvoyé des données, affichez la ville dans le Text.
                                        return Text(
                                          snapshot.data ??
                                              'Ville inconnue', // Gestion de la valeur nulle
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(int.parse(
                                                state.visitedUser.textColor)),
                                            fontFamily: 'Montserrat',
                                          ),
                                        );
                                      } else {
                                        // Si aucun des cas ci-dessus n'est rempli, affichez un message générique.
                                        return Text('Chargement...');
                                      }
                                    },
                                  )
                                ],
                              ),
                              Text(formatTimestamp(date),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                        int.parse(state.visitedUser.textColor)),
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
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
