import 'package:NearCard/blocs/visited_user/visited_user_bloc.dart';
import 'package:NearCard/model/user.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:NearCard/widgets/modal.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class VisitedUserScreen extends StatelessWidget {
  final VisitedUser visitedUser;

  const VisitedUserScreen({super.key, required this.visitedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(int.parse(visitedUser.bgColor)),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              width: 55,
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
                      'https://nearcard.com/users/${visitedUser.uid}',
                    );
                  },
                ),
              ]),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment:
                  kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                ImageSection(
                    picture: visitedUser.picture,
                    textColor: visitedUser.textColor),
                const SizedBox(
                  height: 40,
                ),
                DelayedDisplay(
                  delay: const Duration(milliseconds: 300),
                  child: UserInfoSection(
                      name: visitedUser.name,
                      prename: visitedUser.prename,
                      title: visitedUser.title,
                      textColor: visitedUser.textColor,
                      company: visitedUser.company),
                ),
                const SizedBox(
                  height: 40,
                ),
                DelayedDisplay(
                  delay: const Duration(milliseconds: 400),
                  child: ContactInfoSection(
                      textColor: visitedUser.textColor,
                      phone: visitedUser.number,
                      email: visitedUser.email ?? "",
                      address: visitedUser.address),
                ),
                const SizedBox(
                  height: 40,
                ),
                DelayedDisplay(
                  delay: const Duration(milliseconds: 500),
                  child: SocialSection(
                      textColor: visitedUser.textColor,
                      linkedin: visitedUser.linkedin,
                      website: visitedUser.website),
                ),
                const SizedBox(
                  height: 40,
                ),
                DelayedDisplay(
                  delay: const Duration(milliseconds: 600),
                  child: QrCodeSection(
                    textColor: visitedUser.textColor,
                    visitedUserId: visitedUser.uid,
                  ),
                ),
              ],
            ),
          ),
        ));
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
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
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
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
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
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.start,
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
            if (linkedin != "") {
              launchUrl(Uri.parse(linkedin));
            } else {
              displayError(
                  context, "Aucun profil LinkedIn n'est associé à ce compte");
            }
          },
          icon: FaIcon(
            FontAwesomeIcons.linkedin,
            color: Color(int.parse(textColor)),
          ),
        ),
        IconButton(
          onPressed: () {
            if (website != "") {
              launchUrl(Uri.parse(website));
            } else {
              displayError(context, "Aucun site web n'est associé à ce compte");
            }
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
  final String visitedUserId;
  final String textColor;

  const QrCodeSection(
      {super.key, required this.textColor, required this.visitedUserId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          QRCodeModal.show(
              context, 'https://nearcard.com/users/${visitedUserId}');
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
