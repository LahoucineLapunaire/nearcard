import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:NearCard/screens/legal/legalNotice.dart';
import 'package:NearCard/screens/legal/privacyPolicy.dart';
import 'package:NearCard/screens/legal/termsOfServices.dart';
import 'package:NearCard/screens/settings/userInfo.dart';
import 'package:NearCard/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    AccountSection(
                      picture: state.currentUser.picture,
                      name: state.currentUser.name,
                      prename: state.currentUser.prename,
                      title: state.currentUser.title,
                    ),
                    const SizedBox(height: 16),
                    UserInfoSettingsSection(
                      context: context,
                      state: state,
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 16,
                      thickness: 1,
                    ),
                    NotificationSection(context: context, state: state),
                    Divider(
                      color: Colors.grey[400],
                      height: 16,
                      thickness: 1,
                    ),
                    SupportSection(
                      name: state.currentUser.name,
                      prename: state.currentUser.prename,
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 16,
                      thickness: 1,
                    ),
                    const LegalSection(),
                    Divider(
                      color: Colors.grey[400],
                      height: 32,
                      thickness: 1,
                    ),
                    const LogoutSection(),
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

class AccountSection extends StatelessWidget {
  final String picture;
  final String name;
  final String prename;
  final String title;
  const AccountSection(
      {super.key,
      required this.picture,
      required this.name,
      required this.prename,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          ImageSection(picture: picture),
          const SizedBox(width: 16),
          Column(
            children: [
              Text(
                "$name $prename",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final String picture;
  const ImageSection({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: picture == ""
              ? const Center(
                  child: FaIcon(
                    FontAwesomeIcons.userPlus,
                    size: 40,
                  ),
                )
              : Image.network(
                  picture,
                  fit: BoxFit.cover,
                )),
    );
  }
}

class UserInfoSettingsSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const UserInfoSettingsSection(
      {super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserInfoSettingsScreen(
              context: context,
              state: state,
            ),
          ),
        );
      },
      leading: const Icon(
        Icons.person,
      ),
      title: const Text(
        'Modifier mes informations',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const NotificationSection({
    super.key,
    required this.context,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.notifications), // Icon on the left side
          title: Text(
            'Notifications', // Text for the title
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            "Activer/désactiver les notifications",
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
          subtitle: const Text(
              "Activer/désactiver les notifications concernant les cartes de visite reçues",
              style: TextStyle(
                fontFamily: 'Montserrat',
              )),
          trailing: Switch(
            activeColor: const Color(0xff001f3f),
            value: state.notification,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                    SettingsEventChangeNotification(
                      notification: value,
                    ),
                  );
            },
          ),
        ),
      ],
    );
  }
}

class SupportSection extends StatelessWidget {
  final String name;
  final String prename;
  const SupportSection({super.key, required this.name, required this.prename});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.help_rounded), // Icon on the left side
          title: Text(
            'Help and Support', // Text for the title
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          title: const Text("Contact support",
              style: TextStyle(
                fontFamily: 'Montserrat',
              )),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SupportModal(
                name: name,
                prename: prename,
              ),
            );
          },
        ),
      ],
    );
  }
}

class LegalSection extends StatelessWidget {
  const LegalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.info), // Icon on the left side
          title: Text(
            'About and Legal', // Text for the title
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          title: const Text("Mentions Légales",
              style: TextStyle(
                fontFamily: 'Montserrat',
              )),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LegalNoticeScreen()));
          },
        ),
        ListTile(
          title: const Text("Conditions d'utilisation",
              style: TextStyle(
                fontFamily: 'Montserrat',
              )),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsOfServicesScreen()));
          },
        ),
        ListTile(
          title: const Text("Politique de Confidentialité",
              style: TextStyle(
                fontFamily: 'Montserrat',
              )),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen()));
          },
        ),
      ],
    );
  }
}

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        LogoutModal.show(context);
      },
      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.logout, color: Colors.red),
        SizedBox(width: 8),
        Text(
          'Se déconnecter',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
      ]),
    );
  }
}
