import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:NearCard/screens/settings/changeCompany.dart';
import 'package:NearCard/screens/settings/changeContact.dart';
import 'package:NearCard/screens/settings/changeEmail.dart';
import 'package:NearCard/screens/settings/changeName.dart';
import 'package:NearCard/screens/settings/changePassword.dart';
import 'package:NearCard/screens/settings/changePicture.dart';
import 'package:NearCard/screens/settings/changeSocial.dart';
import 'package:NearCard/screens/settings/changeTitle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoSettingsScreen extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const UserInfoSettingsScreen({
    super.key,
    required this.context,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 56,
          ),
          const ListTile(
            title: Text(
              'Mes informations',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Modifier mon nom et prénom",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeNameScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Modifier mon adresse email",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeEmailScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Modifier mon mot de passe",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userTie),
            title: const Text("Modifier mon titre",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeTitleScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text("Modifier mon entreprise",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeCompanyScreen()));
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.solidAddressBook),
            title: const Text("Modifier mes coordonnées",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeContactScreen()));
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.globe),
            title: const Text("Modifier mon linkedin et mon site web",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeSocialScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Modifier mon image de profil",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePictureScreen()));
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.palette),
            title: const Text("Modifier mes couleurs de carte",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePictureScreen()));
            },
          ),
        ],
      ),
    );
  }
}
