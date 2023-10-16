import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/utils/email.dart';
import 'package:NearCard/utils/geolocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

class SupportModal extends StatefulWidget {
  final String name;
  final String prename;

  SupportModal({Key? key, required this.name, required this.prename})
      : super(key: key);

  @override
  _SupportModalState createState() => _SupportModalState(name, prename);
}

class _SupportModalState extends State<SupportModal> {
  final String name;
  final String prename;
  TextEditingController objectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  _SupportModalState(this.name, this.prename);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        height: 500,
        child: Column(
          children: [
            Divider(
              color: Colors.black,
              height: 20,
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            if (kIsWeb)
              const Text(
                "Si vous utilisez la version web de NearCard, veuillez nous contacter à l'adresse suivante : moderation.ilili@gmail.com",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (kIsWeb) const SizedBox(height: 10),
            const Text(
              "Contactez l'assistance, faites-nous part de vos questions.",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: objectController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Objet',
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: null,
                controller: messageController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Écrivez votre message ici...',
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                sendSupportMessage(context, name, prename,
                    objectController.text, messageController.text);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: const Size(
                      180, 35), // Set the width and height of the button
                  backgroundColor: Color(
                      0xff001f3f) // Set the background color of the button
                  ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send),
                  SizedBox(width: 10),
                  Text("Envoyer")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
