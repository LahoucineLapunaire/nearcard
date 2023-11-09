import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF001F3F), // Couleur en format hexadécimal
              Color(0xFF0962BD), // Couleur en format hexadécimal
            ],
          ),
        ),
        child: const Column(
          children: [
            DelayedDisplay(
                delay: Duration(milliseconds: 600),
                child: PresentationSection()),
            SizedBox(height: 50),
            DelayedDisplay(
                delay: Duration(milliseconds: 800), child: BulletedList()),
            SizedBox(height: 50),
            DelayedDisplay(
                delay: Duration(milliseconds: 1000), child: CtaSection()),
            SizedBox(height: 50),
            DelayedDisplay(
                delay: Duration(milliseconds: 1200),
                child: ContactSection(email: "LahoucineL.freelance@gmail.com")),
            FooterSection(),
          ],
        ),
      ),
    ));
  }
}

class PresentationSection extends StatelessWidget {
  const PresentationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'NearCard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Partager vos cartes de visite en un clic',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bienvenue dans l\'ère moderne de la gestion des cartes de visite avec NearCard ! \n NearCard est bien plus qu\'une simple application, c\'est une solution innovante conçue pour faciliter l\'échange et la gestion de cartes de visite professionnelles. Notre objectif est de simplifier le processus de partage de contacts, que ce soit lors de salons, de conférences, de réseautage ou même dans votre quotidien professionnel.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletedList extends StatelessWidget {
  const BulletedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fonctionnalités",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 16),
          BulletPoint(
            "Partage de Carte de Visite en un Clic :",
            "NearCard vous permet d'échanger des cartes de visite électroniques avec vos collègues, partenaires et prospects en un seul clic. Plus besoin de fouiller dans votre portefeuille à la recherche de cartes en papier, tout est accessible instantanément depuis votre appareil.",
          ),
          BulletPoint(
            "Échange Automatique :",
            "Grâce à la géolocalisation, l'application vous permet d'échanger automatiquement vos cartes de visite avec les personnes à proximité. Que vous assistiez à un salon professionnel ou à un événement de réseautage, NearCard fait le travail pour vous, simplifiant ainsi la création de nouveaux contacts.",
          ),
          BulletPoint(
            "Créez, Modifiez et Envoyez :",
            "Créez votre carte de visite personnalisée avec toutes les informations importantes, de vos coordonnées professionnelles à vos médias sociaux. Vous pouvez également la mettre à jour à tout moment, garantissant que vos contacts ont toujours vos informations les plus récentes.",
          ),
          BulletPoint(
            "Partage Facile via un Lien :",
            "Ne vous inquiétez plus des restrictions de plateforme. Partagez votre carte de visite avec des clients et des partenaires en leur envoyant simplement un lien. C'est aussi simple que ça.",
          ),
          BulletPoint(
            "Système de Recherche :",
            "Vous pouvez rechercher les cartes de visite des autres utilisateurs de la plateforme, ce qui facilite la connexion avec des professionnels partageant les mêmes intérêts.",
          ),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String title;
  final String text;

  const BulletPoint(this.title, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenSection extends StatelessWidget {
  const ScreenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Vous pouvez ajouter ici l'action à effectuer lors du clic sur le bouton CTA.
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green, // Couleur du texte du bouton
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/google.png', // Assurez-vous d'ajouter l'image du logo Google Play Store dans votre dossier d'actifs.
            width:
                30, // Ajustez la largeur de l'image en fonction de vos préférences.
            height:
                30, // Ajustez la hauteur de l'image en fonction de vos préférences.
          ),
          const SizedBox(width: 10), // Espacement entre l'image et le texte
          const Text(
            'Télécharger sur Google Play',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final String email;

  const ContactSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contactez-nous',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Si vous avez des questions ou avez besoin d\'assistance, n\'hésitez pas à nous contacter par e-mail :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      color: const Color(0xFF001F3F)
          .withOpacity(0.8), // Customize the background color
      child: const Column(
        children: [
          SizedBox(height: 10),
          Text(
            'Nous contactez',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Vous avez des questions ou besoin d'aide ?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Email: lahoucinel.freelance@gmail.com',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Phone: +33 6 51 85 84 14',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
