import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String test = "loading...";

  @override
  void initState() {
    super.initState();
    getTestFieldInFirestore();
  }

  void getTestFieldInFirestore() {
    try {
      FirebaseFirestore.instance
          .collection('test')
          .doc('NOiviclazv6K7Lxz0zyw')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            test = documentSnapshot.get("test");
          });
          print('Document data: $test');
        } else {
          print('Document does not exist on the database');
        }
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Firestore Test'),
            ),
            body: Center(
              child: Text(test),
            )));
  }
}
