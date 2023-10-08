import 'dart:io';

import 'package:NearCard/blocs/current_user/current_user_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CurrentUserNotFound) {
          return Center(child: Text("Utilisateur non trouvé"));
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xff001f3f), // Background color
                    ),
                    child: Row(children: [
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          print("Share");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          print("Settings");
                        },
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              floatingActionButton: state.currentUser.cardShare
                  ? FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: () {
                        context.read<CurrentUserBloc>().add(
                            CurrentUserShareCard(
                                share: !state.currentUser.cardShare));
                      },
                      child: Icon(Icons.share),
                    )
                  : FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () {
                        context.read<CurrentUserBloc>().add(
                            CurrentUserShareCard(
                                share: !state.currentUser.cardShare));
                      },
                      child: Icon(Icons.stop),
                    ),
              body: Center(
                child: Column(
                  children: [
                    DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: ImageSection(
                          picture: state.currentUser.picture,
                          textColor: state.currentUser.textColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 600),
                      child: UserInfoSection(
                          name: state.currentUser.name,
                          prename: state.currentUser.prename,
                          title: state.currentUser.title,
                          textColor: state.currentUser.textColor,
                          company: state.currentUser.company),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 700),
                      child: ContactInfoSection(
                          textColor: state.currentUser.textColor,
                          phone: state.currentUser.number,
                          email: auth.currentUser!.email ?? "",
                          address: state.currentUser.address),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 800),
                      child: SocialSection(
                          textColor: state.currentUser.textColor,
                          linkedin: state.currentUser.linkedin,
                          website: state.currentUser.website),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ));
        }
        return Center(child: CircularProgressIndicator());
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
      width: 80,
      height: 80,
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
          name + "" + prename,
          style: TextStyle(
            fontSize: 32,
            color: Color(int.parse(textColor)),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Color(int.parse(textColor)),
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          company,
          style: TextStyle(
            fontSize: 16,
            color: Color(int.parse(textColor)),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
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
          FaIcon(FontAwesomeIcons.envelope, color: Color(int.parse(textColor))),
          Text(
            email,
            style: TextStyle(
              fontSize: 24,
              color: Color(int.parse(textColor)),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          FaIcon(FontAwesomeIcons.phone, color: Color(int.parse(textColor))),
          Text(
            phone,
            style: TextStyle(
              fontSize: 24,
              color: Color(int.parse(textColor)),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          FaIcon(FontAwesomeIcons.locationDot,
              color: Color(int.parse(textColor))),
          Text(
            address,
            style: TextStyle(
              fontSize: 24,
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
  const SocialSection(
      {super.key,
      required this.linkedin,
      required this.website,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.linkedin,
                color: Color(int.parse(textColor))),
            Text(
              linkedin,
              style: TextStyle(
                fontSize: 24,
                color: Color(int.parse(textColor)),
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            FaIcon(FontAwesomeIcons.globe, color: Color(int.parse(textColor))),
            Text(
              website,
              style: TextStyle(
                fontSize: 24,
                color: Color(int.parse(textColor)),
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
