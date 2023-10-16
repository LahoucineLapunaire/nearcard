import "package:flutter/material.dart";

class LegalNoticeScreen extends StatelessWidget {
  const LegalNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mentions Légales"),
        backgroundColor: Color(0xff001f3f),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mentions Légales",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "L'application NearCard est éditée par l'entreprise individuelle Lahoucine LAPUNAIRE, enregistrée au RCS de Saint-Denis sous le numéro 951388073, dont le siège social est situé au 9 Rue Charles Fourier, 91011 Évry-Courcouronnes.",
            ),
            Text(
              "Numéro de téléphone : 0652432127",
            ),
            Text(
              "Adresse e-mail : lahoucinel.freelance@gmail.com",
            ),
            SizedBox(height: 16),
            Text(
              "Le Directeur de la Publication est : Lahoucine LAPUNAIRE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Les applications mobiles sont hébergées sur l'App Store (Apple) et Google Play (Android). Les deux plates-formes offrent diverses fonctionnalités aux développeurs d'applications, notamment :",
            ),
            Text(
              "Stockage et distribution d'applications",
            ),
            Text(
              "Gestion des téléchargements et des mises à jour",
            ),
            Text(
              "Collecte de commentaires et de notes",
            ),
            Text(
              "Suivi des revenus",
            ),
            SizedBox(height: 16),
            Text(
              "Les développeurs d'applications peuvent soumettre leurs applications à l'App Store et à Google Play via un processus de revue. Une fois l'application approuvée, elle est disponible en téléchargement pour les utilisateurs.",
            ),
            Text(
              "L'App Store et Google Play prélèvent une commission sur les revenus générés par les applications. La commission est de 30 % pour les applications payantes et de 15 % pour les applications gratuites.",
            ),
            SizedBox(height: 16),
            Text(
              "App Store :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Adresse : 1 Infinite Loop, Cupertino, CA 95014, États-Unis",
            ),
            Text(
              "Numéro de téléphone : 1-408-996-1010",
            ),
            SizedBox(height: 16),
            Text(
              "Google Play :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Adresse : 1600 Amphitheatre Parkway, Mountain View, CA 94043, États-Unis",
            ),
            Text(
              "Numéro de téléphone : 1-650-253-0000",
            ),
          ],
        ),
      ),
    );
    ;
  }
}
