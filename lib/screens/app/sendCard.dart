import 'package:NearCard/blocs/visited_user/visited_user_bloc.dart';
import 'package:NearCard/model/user.dart';
import 'package:NearCard/screens/app/home.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference<Map<String, dynamic>> usersCollectionRef =
    firestore.collection('users');

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
    Navigator.pop(context);
    displayMessage(context, "La carte a été envoyée avec succès");
  } catch (e) {
    print(e);
  }
}

Future<VisitedUser> getVisitedUser(String uid) async {
  print("start getVisitedUser");
  print(uid);
  Map<String, dynamic>? result = await usersCollectionRef.doc(uid).get().then(
    (value) {
      return value.data();
    },
  );
  result!['uid'] = uid;
  result['email'] = await getEmailFromUidWeb(uid) ?? "";
  print(result);
  return VisitedUser.fromJson(result);
}

class SearchSendWidget extends SearchDelegate {
  SearchSendWidget();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: usersCollectionRef
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query)
          .where('prename', isGreaterThanOrEqualTo: query)
          .where('prename', isLessThan: query)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final searchResults = snapshot.data!.docs;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final document = searchResults[index];
              return ListTile(
                title: Text(document['username']),
                onTap: () {
                  sendCardToUser(document.id, context);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error occurred while searching.'),
          );
        } else {
          return const Center(
            child: Text('No search results found.'),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(); // Return an empty container when the query is empty
    }

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: usersCollectionRef.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final users = snapshot.data!.docs;
          List<UserHome> suggestion = users
              .map((document) {
                return UserHome(
                  name: document['name'] as String,
                  prename: document['prename'] as String,
                  userId: document.id,
                  profilePicture: document['picture'] as String,
                );
              })
              .where((user) =>
                  user.name.toLowerCase().contains(query.toLowerCase()) ||
                  user.prename.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: suggestion.length,
            itemBuilder: (context, index) {
              UserHome user = suggestion[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                title: Text(user.name + ' ' + user.prename),
                onTap: () async {
                  sendCardToUser(user.userId, context);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error occurred while fetching users.'),
          );
        } else {
          return const Center(
            child: Text('No users found.'),
          );
        }
      },
    );
  }
}

class UserHome {
  final String name;
  final String prename;
  final String profilePicture;
  final String userId;

  UserHome(
      {required this.name,
      required this.prename,
      required this.profilePicture,
      required this.userId});
}
