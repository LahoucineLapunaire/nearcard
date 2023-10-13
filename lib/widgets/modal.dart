import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/utils/geolocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class QRCodeModal extends StatelessWidget {
  final String link;

  QRCodeModal({required this.link});

  static void show(BuildContext context, String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QRCodeModal(link: link);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "QR Code",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            QrImageView(
              data: link,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              "Scannez le QR code pour accéder au lien.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fermer"),
            ),
          ],
        ),
      ),
    );
  }
}

class CardShareModal extends StatelessWidget {
  final BuildContext? widgetContext;

  CardShareModal({this.widgetContext});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CardShareModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Activer le partage de NearCard ?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Voulez-vous activer le partage de carte et commencer à partager votre carte avec les personnes proches ? Vous aller partager votre carte de visite pendant 30 minutes.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Annuler"),
                ),
                ElevatedButton(
                  onPressed: () {
                    startWorkManager();
                    Navigator.of(context).pop();
                  },
                  child: Text("Activer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutModal extends StatelessWidget {
  LogoutModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Voulez vous vraiment vous déconnecter ?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Voulez-vous vraiment vous déconnecter de votre compte ? vous pourrez vous reconnecter plus tard en utilisant votre adresse e-mail et votre mot de passe.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: Text("Annuler"),
                ),
                ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Se déconnecter"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
