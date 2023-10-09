import 'dart:io';

import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:NearCard/screens/settings/settings.dart';
import 'package:NearCard/widgets/modal.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              backgroundColor: Color(int.parse(state.currentUser.bgColor)),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xff001f3f), // Background color
                    ),
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          print("Share");
                          Share.share(
                            'https://nearcard.com/users/${auth.currentUser!.uid}',
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SettingsScreen()));
                        },
                      ),
                    ]),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor:
                    state.currentUser.cardShare ? Colors.red : Colors.green,
                onPressed: () {
                  CardShareModal.show(
                      context,
                      state.currentUser.cardShare,
                      (value) => {
                            context
                                .read<CurrentUserBloc>()
                                .add(CurrentUserShareCard(share: value))
                          });
                },
                child: state.currentUser.cardShare
                    ? Icon(Icons.stop)
                    : Icon(Icons.share),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: ImageSection(
                            picture: state.currentUser.picture,
                            textColor: state.currentUser.textColor),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 600),
                        child: UserInfoSection(
                            name: state.currentUser.name,
                            prename: state.currentUser.prename,
                            title: state.currentUser.title,
                            textColor: state.currentUser.textColor,
                            company: state.currentUser.company),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 700),
                        child: ContactInfoSection(
                            textColor: state.currentUser.textColor,
                            phone: state.currentUser.number,
                            email: auth.currentUser!.email ?? "",
                            address: state.currentUser.address),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 800),
                        child: SocialSection(
                            textColor: state.currentUser.textColor,
                            linkedin: state.currentUser.linkedin,
                            website: state.currentUser.website),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      DelayedDisplay(
                        delay: const Duration(milliseconds: 900),
                        child: QrCodeSection(
                          textColor: state.currentUser.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ImageSection extends StatelessWidget {
  final String picture;
  final String textColor;
  const ImageSection(
      {super.key, required this.picture, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Color(int.parse(textColor)), width: 2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: picture == ""
              ? Center(
                  child: FaIcon(
                    FontAwesomeIcons.userPlus,
                    size: 40,
                    color: Color(int.parse(textColor)),
                  ),
                )
              : Image.network(
                  picture,
                  fit: BoxFit.cover,
                )),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  final String name;
  final String prename;
  final String title;
  final String company;
  final String textColor;
  const UserInfoSection(
      {super.key,
      required this.name,
      required this.prename,
      required this.title,
      required this.company,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$name $prename",
          style: TextStyle(
            fontSize: 24,
            color: Color(int.parse(textColor)),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Color(int.parse(textColor)),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          company,
          style: TextStyle(
            fontSize: 16,
            color: Color(int.parse(textColor)),
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}

class ContactInfoSection extends StatelessWidget {
  final String phone;
  final String email;
  final String address;
  final String textColor;
  const ContactInfoSection(
      {super.key,
      required this.phone,
      required this.email,
      required this.address,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          FaIcon(FontAwesomeIcons.solidEnvelope,
              color: Color(int.parse(textColor))),
          SizedBox(
            width: 8,
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: 16,
              color: Color(int.parse(textColor)),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        children: [
          FaIcon(FontAwesomeIcons.phone, color: Color(int.parse(textColor))),
          SizedBox(
            width: 8,
          ),
          Text(
            phone,
            style: TextStyle(
              fontSize: 16,
              color: Color(int.parse(textColor)),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        children: [
          FaIcon(FontAwesomeIcons.locationDot,
              color: Color(int.parse(textColor))),
          SizedBox(
            width: 8,
          ),
          Text(
            address,
            style: TextStyle(
              fontSize: 16,
              color: Color(int.parse(textColor)),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      )
    ]);
  }
}

class SocialSection extends StatelessWidget {
  final String linkedin;
  final String website;
  final String textColor;

  const SocialSection({
    super.key,
    required this.linkedin,
    required this.website,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Redirigez vers le profil LinkedIn lorsque cet IconButton est pressé.
            launchUrl(Uri.parse(linkedin));
          },
          icon: FaIcon(
            FontAwesomeIcons.linkedin,
            color: Color(int.parse(textColor)),
          ),
        ),
        IconButton(
          onPressed: () {
            launchUrl(Uri.parse(website));
          },
          icon: FaIcon(
            FontAwesomeIcons.globe,
            color: Color(int.parse(textColor)),
          ),
        ),
      ],
    );
  }
}

class QrCodeSection extends StatelessWidget {
  final String textColor;

  const QrCodeSection({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          QRCodeModal.show(
              context, 'https://nearcard.com/users/${auth.currentUser!.uid}');
        },
        child: Center(
          child: Text(
            "Voir le QR Code",
            style: TextStyle(
              fontSize: 16,
              color: Color(int.parse(textColor)),
              fontFamily: 'Montserrat',
            ),
          ),
        ));
  }
}
