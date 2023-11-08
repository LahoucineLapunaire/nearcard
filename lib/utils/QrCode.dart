import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/screens/app/home.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> isCardAlreadySent() async {
  bool isCardSent = false;
  await firestore
      .collection('users')
      .doc(auth.currentUser!.uid)
      .get()
      .then((value) {
    if (value.data()!['cardSent'] != null) {
      value.data()!['cardSent'].forEach((element) {
        if (element['receiver'] == auth.currentUser!.uid) {
          isCardSent = true;
        }
      });
    }
  });
  return isCardSent;
}

void sendCardToUser(String uid, BuildContext context) async {
  try {
    if (await isCardAlreadySent()) {
      displayError(context, "La carte a déjà été envoyée");
      return;
    }
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'cardSent': FieldValue.arrayUnion([
        {
          'sender': auth.currentUser!.uid,
          'receiver': uid,
          'date': DateTime.now(),
        }
      ])
    });
    await firestore.collection('users').doc(uid).update({
      'cardReceived': FieldValue.arrayUnion([
        {
          'sender': auth.currentUser!.uid,
          'receiver': uid,
          'date': DateTime.now(),
        }
      ])
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CurrentUserBloc(),
                  child: HomeScreen(),
                )));
    displayMessage(context, "La carte a été scanée avec succès");
  } catch (e) {
    print(e);
  }
}

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner de QR Code'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool isScanner = false;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanner) {
        isScanner = true;
        if (scanData.code!.isNotEmpty) {
          sendCardToUser(scanData.code!, context);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
